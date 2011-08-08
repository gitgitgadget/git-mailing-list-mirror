From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Tue, 9 Aug 2011 01:04:19 +0200
Message-ID: <CAGdFq_gY3-1fv8TiHj=8ppS=AE4B-rwwUL-iKHcjvVtqQa8UAA@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org> <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vpqkfv8x1.fsf@alter.siamese.dyndns.org> <CAGdFq_jzraS-_afjs+MmRS4ML805h73hXAjrRkrQ=tGUdSQqkQ@mail.gmail.com>
 <7vd3gfv7gd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYso-000498-NK
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab1HHXFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 19:05:00 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:32970 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab1HHXFA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 19:05:00 -0400
Received: by pzk37 with SMTP id 37so9037695pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PRSG5B6/O0FEOpRuSJqhWZ+GMH6fAJZGnGuiDS+1oQU=;
        b=vy8effvLQ9UMnjByos2dJrrxq6UwEcih0hw49MvMUskpz3cTT3Ive3mwKR8La7k4s5
         BHUor/OvDuteaBjctd8+6i6+cYo6ah+RFPok+SOCmxrv+t6TiZ7YJ0bM5QWCooxtP6V+
         Xy9I8p27io23arMHmW/MAwDo6tABtcvjQ0RPI=
Received: by 10.143.13.10 with SMTP id q10mr6548745wfi.64.1312844699142; Mon,
 08 Aug 2011 16:04:59 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 16:04:19 -0700 (PDT)
In-Reply-To: <7vd3gfv7gd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179004>

Heya,

On Tue, Aug 9, 2011 at 00:56, Junio C Hamano <gitster@pobox.com> wrote:
> Would we have the same issue with "git bundle", by the way, caused by=
 the
> same setup_revisions() limitation? =C2=A0Over there we would also nee=
d to
> decide the set of refs that the user wanted to record their values wh=
ile
> computing the set of commits we would need to transfer.

I think so.

$ git init test && cd test
Initialized empty Git repository in /home/sverre/code/test/test/.git/
$ echo content >> file
$ git add file && git commit -m "first"
[master (root-commit) c7f5a27] first
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
$ (git init ../another && cd ../another && git pull ../test)
Initialized empty Git repository in /home/sverre/code/another/.git/
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom ../test
 * branch            HEAD       -> FETCH_HEAD
sverre@laptop-sverre:~/code/test
$ git branch second
$ git bundle create bundle second
Counting objects: 3, done.
Writing objects: 100% (3/3), 215 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
sverre@laptop-sverre:~/code/test
$ mv bundle ../another/
$ (cd ../another/ && git bundle unbundle bundle)
c7f5a273b11a438bf78aecff0dfcbb8b16344555 refs/heads/second
$ (cd ../another/ && git for-each-ref)
c7f5a273b11a438bf78aecff0dfcbb8b16344555 commit	refs/heads/master

--=20
Cheers,

Sverre Rabbelier
