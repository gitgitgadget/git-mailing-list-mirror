From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: fix default regex settings on Darwin
Date: Sat, 11 May 2013 00:04:23 -0700
Message-ID: <20130511070423.GG3394@elie>
References: <1368248913-95188-1-git-send-email-davvid@gmail.com>
 <20130511063132.GF3394@elie>
 <CAJDDKr5StD_bDr7+29qEYc4Lza+q8w=ZrHuwdSLwvCSru3YYWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 09:04:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub3rJ-0007II-Sq
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 09:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab3EKHEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 03:04:31 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:63099 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3EKHEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 03:04:30 -0400
Received: by mail-ea0-f170.google.com with SMTP id f15so1154843eak.29
        for <git@vger.kernel.org>; Sat, 11 May 2013 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=a88zcnwnXwWn/247nteFlEkN6Cn3I3jplP1ijpfouAs=;
        b=qFJy75Z8QoiPGuLvD4QZ4VoF23dYww8+WF1UiLTaoNuuqsvwPj64pCxabNHt+PTF7n
         eplXyorJy6EDDjOJVYdLmC0rplKO5xAC+dL7BMq+/kN96sq/xAyuEUq/Zm+5VgWef85P
         Sfwe8eqOuEi7VeThtI/+JuuP3OUe7LY80v5g/mu7/mWOPfxFkKGgroc4ukKCFdN86eyX
         RtPLH8HmODkaq7WRdQl3oJhHRL5WS4Bht8IZGdPrNsaiKR975K6hIc3FJghMiZMwQ42l
         d4XC1XNUVoBMRILqB/ImW3xmfiofzqgyNvMe1aRVP6+K0VZbun/tK4dZKKYu7Bl08gjG
         jGkA==
X-Received: by 10.14.108.1 with SMTP id p1mr50473190eeg.31.1368255868948;
        Sat, 11 May 2013 00:04:28 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id l6sm8163049eem.9.2013.05.11.00.04.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 00:04:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr5StD_bDr7+29qEYc4Lza+q8w=ZrHuwdSLwvCSru3YYWQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223936>

David Aguilar wrote:

> expecting success:
> # if this test fails, re-build git with NO_REGEX=1
> test-regex
>
> fatal: regex bug confirmed: re-build git with NO_REGEX=1

Thanks.  Gah.  That means that regcomp() with REG_NEWLINE is letting

	[^={} \t]+

match the newline in

	={}\nfred

despite the POSIX requirement

	A <newline> in string shall not be matched by a period outside
	a bracket expression or by any form of a non-matching list

where

	A non-matching list expression begins with a <circumflex> ('^')
	and specifies a list that shall match any single-character
	collating element except for the expressions represented in
	the list after the leading <circumflex>.

and if I understand you correctly, this is a regression in Apple
libc. :(

With the commit message modified to mention the "fatal: regex bug
confirmed: re-build git with NO_REGEX=1" and uname -a output,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Do you know if this has been reported to Apple and
openradar.appspot.com?
