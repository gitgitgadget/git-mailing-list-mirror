From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 09/13] revert: Catch incompatible command-line options early
Date: Sat, 2 Jul 2011 15:17:15 +0530
Message-ID: <BANLkTinN6KdPnuMWbrdE4jf4ijKDC=35Aw@mail.gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-10-git-send-email-artagnon@gmail.com> <20110621170416.GN15461@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 11:47:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcwnd-0003xJ-Bx
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 11:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab1GBJrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 05:47:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65413 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1GBJrg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 05:47:36 -0400
Received: by wwe5 with SMTP id 5so3863267wwe.1
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kvls8DKKeEi2goQw9kPnQEC89/IzeSMMQlNvIgtqngk=;
        b=m+acHyDz6Pm7bZQt1DfBJ8eFzcG0bKxVplRsjfaBx6Nga6910YU3loSfHubuZITgvQ
         WvDTvqVZEuJbOyNBhEclx0MHPx4N7gaCmUwOpZWaOggGzLUf1AeHtUzOkNgpc+w0rDa5
         I49UqsA+YryWUxic9eeXSpFgSTWdm8H4ElHPI=
Received: by 10.216.50.2 with SMTP id y2mr3475838web.77.1309600055110; Sat, 02
 Jul 2011 02:47:35 -0700 (PDT)
Received: by 10.216.134.194 with HTTP; Sat, 2 Jul 2011 02:47:15 -0700 (PDT)
In-Reply-To: <20110621170416.GN15461@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176547>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Earlier, incompatible command-line options used to be caught in
>> pick_commits after parse_args has parsed the options and populated t=
he
>> options structure. =C2=A0Instead, hand over the responsibility of ca=
tching
>> incompatible command-line options to parse_args so that the program
>> can die early.
>
> The "Earlier ... used to" phrasing is tripping me up again.
>
> The naive reader (i.e., me) wonders: how long does this option parsin=
g
> and populating the options structure that we want to delay until afte=
r
> verify_opt_compatible take? =C2=A0Does that delay matter or is there =
some
> other reason for this change?


I've tried to spell out the motivation for this change more clearly in
my latest iteration.  Does this look alright?

    revert: Catch incompatible command-line options in parse_args

    Some incompatible command-line options are caught in pick_commits
    after parse_args has parsed the options and populated the options
    structure.  Change this so that parse_args only parses valid
    command-line options instead of returning an unusable options
    structure.  However, this does not mean that we will never need to
    check the options structure; when a sequencer API is written future=
,
    callers will call in with a pre-populated options structure whose
    validity we will still need to check.  Also, provide a
    verify_opt_compatible function to handle incompatible options in a
    general manner.


-- Ram
