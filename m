From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/9] setup_git_directory(): return to original cwd upon
 reaching .git
Date: Sat, 24 Jul 2010 06:15:06 -0500
Message-ID: <20100724111505.GC7150@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:16:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcciO-0002iT-J9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab0GXLQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 07:16:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60514 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0GXLQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:16:08 -0400
Received: by iwn7 with SMTP id 7so1091718iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C1q+WxDGVx4ESSneXzZ+8kLmmwdqjEYr8tw0fkdL2QM=;
        b=xQnmacDNi/efBGn9is0y8guesoCaa4aV+DtfKpPLfcMjKJDGy7+UVM7s5PTB8CbBSl
         rpZQajLfoTKiPp4F4TcykH/67nWR0NumiEiqBBeu7Vz47kwcCJt7XoZ6Quw3nxPXqoNF
         FrLsu8f3rFIN/19qmOKofYNlfAv3g+z3/wbos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ETqtg3h5OaKwLW9O9tYPS1VIy7yLIOyH0CGlukkSuiHlf/bVC1O8dhHnlnUhtNwaAY
         yN84SyxfJq0qwSH2DRrXjmtrHauMtCwVaJQNYPP29xFj2rIthPF9CnRJHI4vcWy/D3gL
         6mHbk5bX6MBhF72taDg72/CDYSKnpLbZIiOR4=
Received: by 10.231.172.205 with SMTP id m13mr5363270ibz.35.1279970167111;
        Sat, 24 Jul 2010 04:16:07 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm1243987ibe.23.2010.07.24.04.16.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:16:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151611>

Hi Duy,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Prefix and cwd should be consistent.

I agree with this, but it took me a while to figure out why your fix
is safe.  Here=E2=80=99s how I figured it out.

Patch 1 cleans up the test script you added a test to.  After cleaning
it up, it is clearer the test does not belong there.

Patch 2 creates a proper home for the new test.

Patches 3-7 split up setup_git_directory_gently() into small enough
pieces that a person with a short attention span can read it now.
No functional change intended.

Patch 8 is your fix.  I removed the comment (which was just confusing
me) and clarified the commit message to compensate

Patch 9 is your patch to revert the other, now redundant fix, also
with commit message tweaks.

After this exercise, your patches still look good. :)  Maybe these
by-products could be useful somehow.

Thoughts (especially improvements) welcome.

Jonathan Nieder (7):
  t1501 (rev-parse): clarify
  tests: try git apply from subdir of toplevel
  setup: split off $GIT_DIR-set case from setup_git_directory_gently
  setup: split off a function to checks working dir for .git file
  setup: split off code to handle stumbling upon a repository
  setup: split off a function to handle hitting ceiling in repo search
  setup: split off get_device_or_die function

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  setup: do not forget working dir from subdir of gitdir
  Revert "rehabilitate 'git index-pack' inside the object store"

 builtin/index-pack.c    |   24 +--
 setup.c                 |  171 ++++++++++--------
 t/t1501-worktree.sh     |  467 ++++++++++++++++++++++++++++++---------=
--------
 t/t4111-apply-subdir.sh |  141 ++++++++++++++
 4 files changed, 547 insertions(+), 256 deletions(-)
 create mode 100755 t/t4111-apply-subdir.sh

--=20
1.7.2.rc3
