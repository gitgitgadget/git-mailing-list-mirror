From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Wed, 5 Dec 2012 04:58:20 -0800
Message-ID: <CANiSa6iirgUjiLMo-wkaT7B_vdaK6s5gQ-CfTqPnDGj_GarWsw@mail.gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
	<1354213975-17866-1-git-send-email-martinvonz@gmail.com>
	<1354213975-17866-2-git-send-email-martinvonz@gmail.com>
	<7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
	<7vzk20p6ik.fsf@alter.siamese.dyndns.org>
	<CANiSa6hWYsfm0t+s_q7=CcD78yNfpuduxkRc35xW8qDOy97W3g@mail.gmail.com>
	<CANiSa6i2f-4jXFUpYV6+fYnpG-tSRRA3cRg_v-v=UrgfwfFz_g@mail.gmail.com>
	<7vd2yunn0e.fsf@alter.siamese.dyndns.org>
	<CANiSa6iMxzQGM8mZYdfR-drPGgydwVpM5JsQ-8oO09MX5XDH+g@mail.gmail.com>
	<7vtxs1kq4z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 13:58:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgEYf-000120-Us
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 13:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab2LEM6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 07:58:22 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53677 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab2LEM6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 07:58:21 -0500
X-Greylist: delayed 33153 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2012 07:58:21 EST
Received: by mail-ie0-f182.google.com with SMTP id s9so8109771iec.41
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 04:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+LheuvMmVyghck2CK8COaxHIoYWZO2Af8EVEuQyLqUU=;
        b=lLTenMnLAf0pbBTsJCtbrYHomDbDUCa/QXauQDUtNUOG4fgR175HLkJkaTa4IBMZMO
         IgwU9Opyl/JTCLkoESM8alj9U8GKlqGyF+L02opj4cJkrphievVrzrJWxv3RMq9+kO44
         rWKbx9N9K4zxW9N4FAEEMOLBPxwmP/PgDaOKpiJ7gScZuPczHqf7LynKld/JSYfBH5zM
         SfkA8UxDLrk/NlQD6AmBqgRbdCkOEky7a97AIPBsQXJ+azZfaQ4rWdgGo80cncO40/af
         Y18ze0lXVsamUQp/fBDTSD8eapL1qWVs+chhOS0BG+eWV33MjjO6IyGMR+t+deGOFFIh
         nkfA==
Received: by 10.50.154.227 with SMTP id vr3mr1688641igb.43.1354712301084; Wed,
 05 Dec 2012 04:58:21 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Wed, 5 Dec 2012 04:58:20 -0800 (PST)
In-Reply-To: <7vtxs1kq4z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211123>

On Tue, Dec 4, 2012 at 9:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> More importantly, when is it desirable not to delete deleted entries?
>
> When I am trying to check out contents of Documentation/ directory
> as of an older edition because we made mistakes updating the files
> in recent versions, with "git checkout v1.9.0 Documentation/", for
> example.  Perhaps somebody had this bright idea of reformatting our
> docs with "= Newer Style =" section headers, replacing the underline
> style, and we found our toolchain depend on the underline style, or
> something.  The new files in the same directory added since v1.9.0
> may share the same mistake as the files whose recent such changes I
> am nuking with this operation, but that does not mean I want to
> retype the contents of them from scratch; I'd rather keep them
> around so that I can fix them up by hand.

I think I follow, but why, then, would you not have the save problem
with hunks *within* files that have been added in the new version? Or
is the only change to Documentation/ since the "broken" commit that a
new file has been added? That seems like a rather narrow use case in
that case? "git checkout -p" seems more generally useful (whether that
command deleted deleted files or not). It feels like I'm missing
something...

> I would have to say that it is more common; I do not recall a time I
> wanted to replace everything in a directory (and only there without
> touching other parts of the tree) with an old version, removing new
> ones.

It has happened a few times for me. I think this usually happens when
I realize that I had a better solution for some subsystem (under some
path) in some other branch (perhaps from a previous attempt at the
same problem) or an in older commit. Knowing that "git checkout $rev
$path" doesn't do what I expect and that "git reset --hard $rev $path"
is not allowed, I think I would usually do "git reset $rev $path &&
git checkout $path".
