From: Luke Hutchison <luke.hutch@gmail.com>
Subject: git leaves repo in bad state in out-of-space situation
Date: Sun, 17 Apr 2011 02:40:26 -0400
Message-ID: <BANLkTi=4EvRZK_bK=JrwiZgfaeHvNgj-dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 08:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBLfV-0008K8-R9
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 08:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab1DQGlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 02:41:08 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50869 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1DQGlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 02:41:07 -0400
Received: by pwi15 with SMTP id 15so1706992pwi.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 23:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=aqzGa3gw7tiJDIfimdjolOuIcKFromXnZOm32hs4SI4=;
        b=iISAV0c8swHwxKeicIxr4HgBcgC3vLem8Hvst4aUwpoyo0DI8Xv544kxnOCIUd1Ma+
         6Gz3+TYtZdewpybKmYGv0c3R712AGPcI1ua5wrK/aq2/GkQljCyrva2XBeApLL49rbAL
         zhv1J4OHXiAtIcN7oesNrvF7RNLpniHtOvHiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=xIzgHKkrDaNxeDAEhASmlw/Q+AE/ONsh0aWV7oIWMJ0ApQyGhT0DvLkLRAQ/1itith
         kwTv/N0otGY7EQKFlta+lt70/HgHpD6tBVfPHrNFHEU3JW4vU8L1hL2Qedh9aBNSFLT6
         +pdT6mZc3JPI2i2J4lqgIhmp+A8gKm9NSSHjw=
Received: by 10.68.2.167 with SMTP id 7mr4738556pbv.310.1303022466043; Sat, 16
 Apr 2011 23:41:06 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Sat, 16 Apr 2011 23:40:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171715>

I just did a git pull and ran out of disk space halfway through, which
left me with a bunch of "Could not create file <filename>" errors.  I
freed up space and tried to repeat the git pull.  Now my repo is
b0rked:

$ git pull
Updating eedace8..a37dbb1
error: Your local changes to the following files would be overwritten by merge:
        <list of some of the pulled files>
Please, commit your changes or stash them before you can merge.
error: The following untracked working tree files would be overwritten by merge:
        <a lot more of the pulled files>

I wasn't sure how to fix this, and this was probably the wrong
response, but I tried "git add . ; git commit -a -m test ; git push"
and got a bunch of merge conflicts due to zero-length binary files
(PNGs etc.).  Repeating this again I get "up to date" but some of my
files have now been replaced in the repo with zero-length versions,
which seems dangerous if I didn't notice it and just assumed that git
had worked its magic and fixed the situation.

I know that gracefully handling out-of-diskspace situations is a pain,
and it's hard to catch each corner case.  But it seems like git could
degrade a little more elegantly in this situation (e.g. files should
not just be created with zero length if there is no disk space left).
Thoughts?

Not sure of the right way to fix my current situation, I'll probably
just overwrite my local copy of the repo with a remote copy using scp
and then try pushing again.

I assume this mailing list is the right place to report bugs, since I
don't see a bug tracker?  I tried looking in the FAQ at
https://git.wiki.kernel.org/index.php/GitFaq , but got:

Database error
A database error has occurred
Query: SELECT lc_value FROM `l10n_cache` WHERE lc_lang = 'en' AND
lc_key = 'deps' LIMIT 1
Function: LCStore_DB::get
Error: 1146 Table 'gitwiki.l10n_cache' doesn't exist (127.0.0.1:4040)

Thanks,
Luke Hutchison
