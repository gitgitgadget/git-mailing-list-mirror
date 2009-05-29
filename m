From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 9/9] Use the default git colouring scheme rather 
	than specific scripts
Date: Fri, 29 May 2009 13:22:48 +0100
Message-ID: <b0943d9e0905290522l377c8f35h7f442b183cb7c7d2@mail.gmail.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
	 <20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
	 <49FEE41F.4010006@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
To: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
X-From: git-owner@vger.kernel.org Fri May 29 14:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA16w-0002RG-Mt
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 14:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198AbZE2MWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 08:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757772AbZE2MWt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 08:22:49 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:58970 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbZE2MWs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 08:22:48 -0400
Received: by ewy24 with SMTP id 24so6220726ewy.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zN86ebW24nh9nok0VPSYLGe4o1X6u/VHwjic1J3kqQA=;
        b=li0VgLOpJLj2mcNg7MtHuzxQEtFbdmxCUGB8YPIMzXECsxAXDSSLCNBnsyD2VnCGpH
         gDMiU6hnG1L4Rn1zrqEnYCiUbOd4CCfZ8BAbdqwruODN/ym1z+38SdbKdsnrtRzIExim
         k8GmkJruJPK1bquk4eknpAaRaMxYV/ZBJ2hvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nIkJ9dexZUTUQ5EbIZkFZTi5VhS+EwpYar4rKkVImiXyd88HR6zyoSh8xGBrEqzr9y
         O1W+u3rvWgSAdsdQe19jsAgo7JbPmtm2YT3mGyY+PRAVtGc8YeGadMHEs8aOwLfH09pw
         b+nTEa/FQvGc/FCWzHbLNMUOfVyRh6QWnDWX4=
Received: by 10.216.2.210 with SMTP id 60mr900174wef.21.1243599768325; Fri, 29 
	May 2009 05:22:48 -0700 (PDT)
In-Reply-To: <49FEE41F.4010006@ruby.dti.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120274>

2009/5/4 Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>:
> Catalin Marinas wrote:
>> =A0+def color_diff_flags():
>> + =A0 =A0"""Return the git flags for coloured diff output if the con=
figuration
>> and
>> + =A0 =A0stdout allows."""
>> + =A0 =A0if sys.stdout.isatty() and config.get('color.diff') in ['tr=
ue',
>> 'auto']:
>> + =A0 =A0 =A0 =A0return ['--color']
>> + =A0 =A0else:
>> + =A0 =A0 =A0 =A0return []
>> +
>> =A0def check_local_changes():
>> =A0 =A0 if git.local_changes():
>> =A0 =A0 =A0 =A0 raise CmdException('local changes in the tree. Use "=
refresh" or'
>
> Junio introduces `color.ui=3Dauto' as one of base settings in his rec=
ent
> Japanese article for Git newbies:

That's probably a better option. I changed the patch to this (only
showing the relevant parts):

--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -97,6 +97,15 @@ def git_commit(name, repository, branch_name =3D Non=
e):
     except libgit.RepositoryException:
         raise CmdException('%s: Unknown patch or revision name' % name=
)

+def color_diff_flags():
+    """Return the git flags for coloured diff output if the configurat=
ion and
+    stdout allows."""
+    stdout_is_tty =3D (sys.stdout.isatty() and 'true') or 'false'
+    if config.get_colorbool('color.diff', stdout_is_tty) =3D=3D 'true'=
:
+        return ['--color']
+    else:
+        return []
+
 def check_local_changes():
     if git.local_changes():
         raise CmdException('local changes in the tree. Use "refresh" o=
r'

--- a/stgit/config.py
+++ b/stgit/config.py
@@ -109,16 +110,18 @@ class GitConfig:
             if m:
                 result.append(m.group(1))
         return result
+
+    def get_colorbool(self, name, stdout_is_tty):
+        """Invoke 'git config --get-colorbool' and return the result."=
""
+        return Run('git', 'config', '--get-colorbool', name,
+                   stdout_is_tty).output_one_line()

 config=3DGitConfig()

>> diff --git a/stgit/config.py b/stgit/config.py
>> index efce097..4f16978 100644
>> --- a/stgit/config.py
>> +++ b/stgit/config.py
>> @@ -37,7 +37,8 @@ class GitConfig:
>> =A0 =A0 =A0 =A0 'stgit.autoimerge': =A0 =A0'no',
>> =A0 =A0 =A0 =A0 'stgit.keepoptimized': 'no',
>> =A0 =A0 =A0 =A0 'stgit.extensions': =A0 =A0'.ancestor .current .patc=
hed',
>> - =A0 =A0 =A0 =A0'stgit.shortnr': =A0 =A0 =A0 =A0'5'
>> + =A0 =A0 =A0 =A0'stgit.shortnr': '5',
>> + =A0 =A0 =A0 =A0'stgit.pager': =A0'less -FRSX'
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 __cache=3D{}
>
> Wrong indentation? :-)

The indentation is right, only that in the past there was a tab left
which I removed with this occasion.

--=20
Catalin
