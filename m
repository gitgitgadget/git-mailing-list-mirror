From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 5/5] rebase [-m]: calculate patches in upstream correctly
Date: Wed, 27 Jun 2012 09:17:53 -0700
Message-ID: <CAOeW2eGVdZrccbLaOusirBY6PzpMVhy=gzHrpvTQq0dCLJL71g@mail.gmail.com>
References: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1340722318-24392-6-git-send-email-martin.von.zweigbergk@gmail.com>
	<7v8vf9bwv0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
	Knut Franke <Knut.Franke@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 18:18:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjuwO-0004qA-UI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 18:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073Ab2F0QR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jun 2012 12:17:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50965 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709Ab2F0QRy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2012 12:17:54 -0400
Received: by pbbrp8 with SMTP id rp8so1757829pbb.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VUDGfM/mGFsm7oWyrCzaHQegZ1KwCKYtoIu4oRhTR8Q=;
        b=AP6/mzzS1RtWX1VbA+bmTOiN6nVNTGmBHBlZaMRk9eJfTxNQnNZEXpCPlohJqTmnsc
         x3f2Exl0NKiouQAkc5OPge9E6zn+ddW7BMQoQDj2kKPGZZHxTF+Aq3Z9OZ4fMNlDhKw9
         H6vCVFnzwKhccnn36C5BlAJxqSm9HoPlW5B1dS857V/8H48gLKH/CqAhYKL/poTvpcKK
         dedSEHJ7k6+sWfUWLSHCFQe/6jyn/mkaYtI03BiDU7h9tOUYfHJvPVwvgMnWtdTruJog
         Zov1pb6PEWNucweWiJNfB/DZs6IyP54/39Q1OiBkNo8R04485AvUfcA3c5cpn1ucswuo
         L8fw==
Received: by 10.68.232.161 with SMTP id tp1mr65638549pbc.44.1340813873487;
 Wed, 27 Jun 2012 09:17:53 -0700 (PDT)
Received: by 10.68.218.98 with HTTP; Wed, 27 Jun 2012 09:17:53 -0700 (PDT)
In-Reply-To: <7v8vf9bwv0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200726>

On Tue, Jun 26, 2012 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Hrm, why does this break 9140.6? =C2=A0Has the test been expecting a
> wrong result?

I wish I could say that it was. I guess I never had the subversion
libraries installed while running the test cases :-(. It turns out
that that test case happens to create an empty commit. So when I
changed from git-format-patch to git-cherry for calculating the
revisions to rebase, it started including empty commits. It also turns
out we don't have any test cases specifically for rebasing empty
commits, so I'm glad 9140.6 caught it. I'll send out a patch that adds
a test case for rebasing of empty commit, which should be good
regardless of whether the current patch, in some form, is eventually
accepted.

I got all the tests to pass by special-casing empty patches in
git-am.sh when $rebasing, but I'm now unsure about this patch for a
few reasons:

 1) I suppose the $revisions passed to git-am and may result in too
long a command line. This should be fixable by replacing it by a
function, I guess.

 2) The new --keep-empty stuff is clearly closely related to these
changes and at least the 'if test -n "$keep_empty"' block in
git-rebase--am.sh could possibly be replaced by similar logic in
git-am.sh by passing the --keep-empty to it. Using git-am should make
it faster, which it the whole point of using git-am instead of
git-cherry-pick, IIUC.

I'm not sure when I'll get time to work on these issues. If someone
else feels the urge, please go ahead.

Martin
