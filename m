From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 09/17] revert: Don't create invalid replay_opts in parse_args
Date: Sun, 17 Jul 2011 17:26:52 +0530
Message-ID: <CALkWK0kcZi87watFTZCFUJpNf1T-wnRPyQ6FcDxmvFzAZE3osg@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-10-git-send-email-artagnon@gmail.com> <20110712182958.GE14120@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 13:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiPyI-0003n5-IB
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 13:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab1GQL5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 07:57:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36056 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab1GQL5N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 07:57:13 -0400
Received: by wwe5 with SMTP id 5so2437452wwe.1
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cvCezQhTVmlVKeB3fpnXyNRLWP9aHb9yqR2H14HaxKQ=;
        b=vgSnNkBO4g80FojswESk1vsghsbNoHCbGmuSW1uPXoVqTGNJVA3wU5Hl1IAlWsR/9J
         7efNkeKbLy0dQbR0aOi33Oe3IBP5GXk2IYKWPQu9JRk87IClLUpSYJ4HFitXvSnWd+w4
         2B3HVtDItbSyeIwLpmZx/GpFSzjcHRq7VHSsI=
Received: by 10.216.234.143 with SMTP id s15mr2151675weq.66.1310903832090;
 Sun, 17 Jul 2011 04:57:12 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Sun, 17 Jul 2011 04:56:52 -0700 (PDT)
In-Reply-To: <20110712182958.GE14120@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177297>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> The "--ff" command-line option cannot be used with four other
>> command-line options.
>
> The above sounds like --ff is a bit of a diva and does not like to
> be on a commandline with argc >=3D 6. =C2=A0But I get the idea.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  New commit message de-emphasizing "four":

revert: Don't create invalid replay_opts in parse_args

The "--ff" command-line option cannot be used with some other
command-line options.  However, parse_args still parses these
incompatible options into a replay_opts structure for use by the rest
of the program.  Although pick_commits, the current gatekeeper to the
cherry-pick machinery, checks the validity of the replay_opts
structure before before starting its operation, there will be multiple
entry points to the cherry-pick machinery in future.  To futureproof
the code and catch these errors in one place, make sure that an
invalid replay_opts structure is not created by parse_args in the
first place.  Also ensure that regressions in maintaining this
invariant are caught in the future by adding an assertion in
pick_commits.

-- Ram
