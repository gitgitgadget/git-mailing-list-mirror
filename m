From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
	index)
Date: Mon, 13 Apr 2009 18:59:43 +0200
Message-ID: <fabb9a1e0904130959y20ff66a8la426f33dc0a9bf8b@mail.gmail.com>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de> 
	<61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de> 
	<46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com> 
	<46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com> 
	<alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de> <fabb9a1e0904101159w7ab19247k81f4b67b8a91198f@mail.gmail.com> 
	<alpine.DEB.1.00.0904131817160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 13 19:01:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtPXQ-0003bt-7k
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 19:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZDMRAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 13:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZDMRAE
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 13:00:04 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:26539 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbZDMRAB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 13:00:01 -0400
Received: by mu-out-0910.google.com with SMTP id g7so885030muf.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=P0gZMLsKyW4AjvTq9RTV/ZxNsiSDdRCBC1E5lpErmVs=;
        b=kg5iMXS2F4t4DIlEQEehEFMCHgmrq/loj0LPE1tXgVh259UN0NlIKyO+po0I6BOF7Z
         b9xAa8f2P4PXNku/Mlh/UH8nKNtudqzimAI0YBfWH1315Dua4eQjQ7+Rs6NYVmp9GyEi
         YhkFsHrHdhHrR+vJIPtqK3WtBV/Eypzss4X0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nQ8LFHCcxBfPsTAVcnxbv+sXmjrGGSSF1xuQua68BrrKl0lOO/jXogJSFpG2fcxeiM
         jvKhNdnYUc1QewP0DxhUKTtxKtzdqxj6pTtAAxQ/RWYmIjOWNUt0e0nkSI7witP1Jz+7
         lFpNYcKy398TfLFeEuxfI9tcU6AbAUwyCW98Q=
Received: by 10.103.238.4 with SMTP id p4mr3431277mur.68.1239641998178; Mon, 
	13 Apr 2009 09:59:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904131817160.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116452>

Heya,

On Mon, Apr 13, 2009 at 18:19, Johannes Schindelin
<Johannes.Schindelin@gmx.de> > Would not a much saner way be
>
> =A0 =A0 =A0 =A0$ git reset HEAD^
> =A0 =A0 =A0 =A0$ git add -p
> =A0 =A0 =A0 =A0$ git stash save --keep-index
> =A0 =A0 =A0 =A0# test it
> =A0 =A0 =A0 =A0$ git commit
> =A0 =A0 =A0 =A0$ git stash apply
> =A0 =A0 =A0 =A0# test again
> =A0 =A0 =A0 =A0$ git commit

That's what I do already, but now imagine that at the # test it step I
notice that I staged too much, or need to tweak some value only in
this commit (e.g., change test_expect_success to test_expect_failure
because this commit is the test that indicates the failure, and the
next one will fix it and flip from expect_failure to expect_success).
At the moment I have to make the change in my working directory (which
potentially involved deleting a lot of hunks), stage that and _then_
make my commit. With 'git add -e' I can make the fix and happily
continue.

--=20
Cheers,

Sverre Rabbelier
