From: Matt McCutchen <hashproduct@verizon.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Wed, 29 Mar 2006 22:01:50 -0500
Message-ID: <1143687710.2524.1.camel@mattlaptop.metaesthetics.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<7vmzfac7gn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+Imm101Ts9e581ScjeOW"
X-From: git-owner@vger.kernel.org Thu Mar 30 05:01:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOnQ6-00019X-1s
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 05:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWC3DBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 22:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWC3DBz
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 22:01:55 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:38601 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751224AbWC3DBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 22:01:54 -0500
Received: from [192.168.1.5] ([151.200.44.96])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IWX00K1G734AOY0@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 29 Mar 2006 21:01:53 -0600 (CST)
In-reply-to: <7vmzfac7gn.fsf@assigned-by-dhcp.cox.net>
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.0 (2.6.0-1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18186>


--=-+Imm101Ts9e581ScjeOW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-03-28 at 18:26 -0800, Junio C Hamano wrote:
>        v2.6.15           v2.6.16
>     ---o---o---o---...---o---o
>         \                     \
>          \                     y---y---y 2.6.16-matt
>           \                 
>            o---o---o v2.6.15.6
>                     \
>                      x---x---x 2.6.15.6-matt
> 
> to happen, where y---y---y are analogous to x---x---x.
> 
> Assuming your branches are:
> 
>         origin - v2.6.15.6 (from stable team)
>         master - your changes (2.6.15.6-matt)

Beautiful diagram.  This is exactly my situation.

> you could:
> 
>         $ git fetch git://../torvalds/linux-2.6.git tag v2.6.16
>         $ git checkout -b 2.6.16-matt v2.6.16
>         $ git format-patch origin master | git am -3

This looks like what I want.  When I run the third command, however, I
get "no patch found".  Four files corresponding to my four commits
appear in my repository; I have attached them.  What is wrong?

> Alternatively, you might want to do a real merge:
> [...] If you do not understand
> what the stable team did in order to reimplement certain fixes,
> you would have a very difficult time deciding on how to resolve
> conflicts with this merge.

Yes, I think this is the problem what I ran into before when I was
trying to pull.

Perhaps this is just politics, but which kernel repository is more
official, and why?  Linus's or the one I have been using,
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
?

Thanks for the help!
-- 
Matt McCutchen
hashproduct@verizon.net
http://hashproduct.metaesthetics.net/

--=-+Imm101Ts9e581ScjeOW
Content-Disposition: attachment; filename*0=0001-Changes-for-Matt-s-custom-kernel-the-Stickier-Patch-and-; filename*1=appropriate-markers.txt
Content-Type: text/plain; name*0=0001-Changes-for-Matt-s-custom-kernel-the-Stickier-Patch-and-appr; name*1=opriate-markers.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

>From nobody Mon Sep 17 00:00:00 2001
From: Matt McCutchen <matt@mattlaptop.metaesthetics.net>
Date: Sun Mar 5 20:14:20 2006 -0500
Subject: [PATCH] Changes for Matt's custom kernel: the Stickier Patch and appropriate markers.

---

 Documentation/filesystems/stickier.txt |   24 ++++++
 README.matt                            |    1 
 fs/namei.c                             |  132 ++++++++++++++++++++++++++------
 localversion-matt                      |    1 
 4 files changed, 132 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/filesystems/stickier.txt
 create mode 100644 README.matt
 create mode 100644 localversion-matt

6a2fe5757614310ca63e7b2bac1acb5c2081d86c
diff --git a/Documentation/filesystems/stickier.txt b/Documentation/filesystems/stickier.txt
new file mode 100644
index 0000000..03db966
--- /dev/null
+++ b/Documentation/filesystems/stickier.txt
@@ -0,0 +1,24 @@
+Matt McCutchen's Stickier Patch
+-------------------------------
+
+In the official Linux kernel's filesystem support, the only thing the sticky bit does is restrict deletion and overwriting of directory entries: you can't unlink or move another file over a file you don't own in a sticky directory you don't own.
+
+The Stickier Patch makes two changes to the behavior of the sticky bit.  First, creating a link to a file you don't own in a sticky directory you don't own is now forbidden.  (Doing so used to be possible but irreversible, which I considered an incongruity.)
+
+Second, a sticky directory you don't own has restrictions on lookup by name beyond the requirement of execute permission.  You can always look up a file that you own or on which you have at least one permission (read, write, or execute).  If you try to look up another file, you get EPERM.  If you try to look up a nonexistent file, you get ENOENT if you can read or write the directory, but EPERM if you can only execute it.  These restrictions apply to all path following, so every system call that follows paths can potentially cause EPERM.
+
+Why this change?  If you want to allow everyone on your computer to read a folder in your home directory, you can set its permissions to 755; however, to get to the folder, people need execute on your home directory.  But giving them execute opens the door to loads of abuse.  People can guess filenames and see if those files exist in your home directory; if the files exist, people can stat them and learn their atimes, mtimes, and sizes.  Maybe they won't hit upon any of your personal files, but the names of your mailbox and your dotfiles are likely to be well-known.  People can find out when you last got mail and about how big the mail was, what programs you've used recently, and so forth.
+
+With the Stickier Patch, you can set your home directory sticky (mode 1711).  People can still get to the public folder, but trying to access any other name will cause EPERM.  They can't even learn whether the files exist, much less stat them.
+
+Alternatively, you can set your home directory to mode 1755, in which case others can list the names of all files but only see stat information for the public ones:
+	drwxr-xr-t  81 matt matt 4096 Jan 18 16:13 .
+	drwxr-xr-x   3 root root 4096 Jan  8 16:46 ..
+	?---------   ? ?    ?       ?            ? .bashrc
+	lrwxrwxrwx   1 matt matt   18 Jan 18 16:14 symlink -> some/target/path
+	drwxr-xr-x   1 matt matt   18 Jan 18 16:14 public
+	?---------   ? ?    ?       ?            ? private
+
+Note that the symlink appears and is stattable because it grants everyone every permission; there's nothing you can do about this unless/until I make another patch that adds lchmod and meaningful symlink permissions (r == readlink, w == writelink (to be implemented), x == traverse).  In addition, the Stickier Patch does not change the behavior of readdir, which often gives the i-number and type of a file along with its name.  (In fact, a short-form ls listing will classify private directories as directories, not as unstattable, because short-form ls bases classification on readdir.)
+
+Future versions of the Stickier Patch may address these issues and may also provide a way to set a directory so private entries are hidden from readdir (setuid bit?).  In the meantime, if any of these issues is a concern, one should remove read permission and announce the names of files others may access in another venue so they don't have to guess.
diff --git a/README.matt b/README.matt
new file mode 100644
index 0000000..8df642d
--- /dev/null
+++ b/README.matt
@@ -0,0 +1 @@
+This is Matt McCutchen's custom kernel.  Right now, the only difference between it and the official one is the Stickier Patch, described in Documentation/filesystems/sticker.txt , which changes the behavior of the sticky bit on directories.
diff --git a/fs/namei.c b/fs/namei.c
index 6dbbd42..baea761 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -766,6 +766,66 @@ fail:
 }
 
 /*
+ * It's inline, so penalty for filesystems that don't use sticky bit is
+ * minimal.
+ * MATT -- null inode allowed, it's as if nobody owns it
+ */
+static inline int check_sticky(struct inode *dir, struct inode *inode)
+{
+	if (!(dir->i_mode & S_ISVTX))
+		return 0;
+	if (inode && inode->i_uid == current->fsuid)
+		return 0;
+	if (dir->i_uid == current->fsuid)
+		return 0;
+	return !capable(CAP_FOWNER);
+}
+
+/*
+ * MATT -- Will a new entry refuse to adhere to the directory?  :)
+ */
+static inline int check_unsticky(struct inode *dir, uid_t new_owner)
+{
+	if (!(dir->i_mode & S_ISVTX))
+		return 0;
+	if (new_owner == current->fsuid)
+		return 0;
+	if (dir->i_uid == current->fsuid)
+		return 0;
+	return !capable(CAP_FOWNER);
+}
+
+/*
+ * MATT
+ * Check whether we can traverse a directory entry; return 0 or -Exxxx.
+ * 1. We can if the directory entry isn't sticky for us (see check_sticky).
+ * 2. If the entry points nowhere, we can traverse it if we can read or
+ *    write the directory.
+ * 3. If the entry points to a file, we can traverse it if we can read,
+ *    write, or execute the file.
+ * Because of the clumsy interface, we need several permission checks.
+ */
+static inline int may_traverse(struct inode *dir,struct inode *inode)
+{
+	if (!check_sticky(dir, inode))
+		return 0;
+	if (inode) {
+		if (permission(inode, MAY_READ, NULL) == 0
+			|| permission(inode, MAY_WRITE, NULL) == 0
+			|| permission(inode, MAY_EXEC, NULL) == 0)
+			return 0;
+		else
+			return -EPERM;
+	} else {
+		if (permission(dir, MAY_READ, NULL) == 0
+			|| permission(dir, MAY_WRITE, NULL) == 0)
+			return 0;
+		else
+			return -EPERM;
+	}
+}
+
+/*
  * Name resolution.
  * This is the basic name resolution function, turning a pathname into
  * the final dentry. We expect 'base' to be positive and a directory.
@@ -794,6 +854,7 @@ static fastcall int __link_path_walk(con
 		unsigned long hash;
 		struct qstr this;
 		unsigned int c;
+		struct inode *dirsave;
 
 		nd->flags |= LOOKUP_CONTINUE;
 		err = exec_permission_lite(inode, nd);
@@ -801,6 +862,7 @@ static fastcall int __link_path_walk(con
 			err = vfs_permission(nd, MAY_EXEC);
  		if (err)
 			break;
+		dirsave = inode;
 
 		this.name = name;
 		c = *(const unsigned char *)name;
@@ -852,8 +914,16 @@ static fastcall int __link_path_walk(con
 		if (err)
 			break;
 
-		err = -ENOENT;
 		inode = next.dentry->d_inode;
+		/*
+		 * MATT -- May we traverse the entry?
+		 * inode might be null; may_traverse checks this case and
+		 * might cause EPERM to conceal whether the inode exists.
+		 */
+		err = may_traverse(dirsave, inode);
+		if (err)
+			goto out_dput;
+		err = -ENOENT;
 		if (!inode)
 			goto out_dput;
 		err = -ENOTDIR; 
@@ -906,6 +976,14 @@ last_component:
 		if (err)
 			break;
 		inode = next.dentry->d_inode;
+		/*
+		 * MATT -- May we traverse the entry?
+		 * inode might be null; may_traverse checks this case and
+		 * might cause EPERM to conceal whether the inode exists.
+		 */
+		err = may_traverse(dirsave, inode);
+		if (err)
+			break;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
 			err = do_follow_link(&next, nd);
@@ -1260,21 +1338,6 @@ int fastcall __user_walk(const char __us
 }
 
 /*
- * It's inline, so penalty for filesystems that don't use sticky bit is
- * minimal.
- */
-static inline int check_sticky(struct inode *dir, struct inode *inode)
-{
-	if (!(dir->i_mode & S_ISVTX))
-		return 0;
-	if (inode->i_uid == current->fsuid)
-		return 0;
-	if (dir->i_uid == current->fsuid)
-		return 0;
-	return !capable(CAP_FOWNER);
-}
-
-/*
  *	Check whether we can remove a link victim from directory dir, check
  *  whether the type of victim is right.
  *  1. We can't do it if dir is read-only (done in permission())
@@ -1333,12 +1396,27 @@ static inline int may_delete(struct inod
  *  4. We can't do it if dir is immutable (done in permission())
  */
 static inline int may_create(struct inode *dir, struct dentry *child,
-			     struct nameidata *nd)
+			     struct nameidata *nd, uid_t new_owner)
 {
 	if (child->d_inode)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
+	if (check_unsticky(dir, new_owner))
+		return -EPERM;
+	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
+}
+
+/* Same as may_create but allow the child to already exist.
+ * Separately you should check may_delete on an existing child, if any.
+ */
+static inline int may_create_or_overwrite(struct inode *dir, struct dentry *child,
+			     struct nameidata *nd, uid_t new_owner)
+{
+	if (IS_DEADDIR(dir))
+		return -ENOENT;
+	if (check_unsticky(dir, new_owner))
+		return -EPERM;
 	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
 }
 
@@ -1405,7 +1483,7 @@ void unlock_rename(struct dentry *p1, st
 int vfs_create(struct inode *dir, struct dentry *dentry, int mode,
 		struct nameidata *nd)
 {
-	int error = may_create(dir, dentry, nd);
+	int error = may_create(dir, dentry, nd, current->fsuid);
 
 	if (error)
 		return error;
@@ -1721,7 +1799,7 @@ EXPORT_SYMBOL_GPL(lookup_create);
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
-	int error = may_create(dir, dentry, NULL);
+	int error = may_create(dir, dentry, NULL, current->fsuid);
 
 	if (error)
 		return error;
@@ -1794,7 +1872,7 @@ out:
 
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
-	int error = may_create(dir, dentry, NULL);
+	int error = may_create(dir, dentry, NULL, current->fsuid);
 
 	if (error)
 		return error;
@@ -2032,7 +2110,7 @@ slashes:
 
 int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname, int mode)
 {
-	int error = may_create(dir, dentry, NULL);
+	int error = may_create(dir, dentry, NULL, current->fsuid);
 
 	if (error)
 		return error;
@@ -2092,7 +2170,7 @@ int vfs_link(struct dentry *old_dentry, 
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(dir, new_dentry, NULL);
+	error = may_create(dir, new_dentry, NULL, inode->i_uid);
 	if (error)
 		return error;
 
@@ -2285,12 +2363,14 @@ int vfs_rename(struct inode *old_dir, st
 	if (error)
 		return error;
 
-	if (!new_dentry->d_inode)
-		error = may_create(new_dir, new_dentry, NULL);
-	else
-		error = may_delete(new_dir, new_dentry, is_dir);
+	error = may_create_or_overwrite(new_dir, new_dentry, NULL, old_dentry->d_inode->i_uid);
 	if (error)
 		return error;
+	if (new_dentry->d_inode) {
+		error = may_delete(new_dir, new_dentry, is_dir);
+		if (error)
+			return error;
+	}
 
 	if (!old_dir->i_op || !old_dir->i_op->rename)
 		return -EPERM;
diff --git a/localversion-matt b/localversion-matt
new file mode 100644
index 0000000..fd815c7
--- /dev/null
+++ b/localversion-matt
@@ -0,0 +1 @@
+.matt1
-- 
1.2.4


--=-+Imm101Ts9e581ScjeOW
Content-Disposition: attachment; filename*0=0002-Create-and-add-to-.gitignore-files-so-that-source-tree-i; filename*1=s-git-clean-after-I.txt
Content-Type: text/plain; name*0=0002-Create-and-add-to-.gitignore-files-so-that-source-tree-is-gi; name*1=t-clean-after-I.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

>From nobody Mon Sep 17 00:00:00 2001
From: Matt McCutchen <matt@mattlaptop.metaesthetics.net>
Date: Sun Mar 5 20:16:19 2006 -0500
Subject: [PATCH] Create and add to .gitignore files so that source tree is git-clean after I
build the kernel.

---

 arch/i386/kernel/.gitignore     |    3 +++
 drivers/ieee1394/.gitignore     |    1 +
 drivers/scsi/aic7xxx/.gitignore |    4 ++++
 include/asm-i386/.gitignore     |    1 +
 scripts/kconfig/.gitignore      |    1 +
 5 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 arch/i386/kernel/.gitignore
 create mode 100644 drivers/ieee1394/.gitignore
 create mode 100644 drivers/scsi/aic7xxx/.gitignore
 create mode 100644 include/asm-i386/.gitignore

a52dcfea1864b643a58ab2e1693487037f64f233
diff --git a/arch/i386/kernel/.gitignore b/arch/i386/kernel/.gitignore
new file mode 100644
index 0000000..e8ef014
--- /dev/null
+++ b/arch/i386/kernel/.gitignore
@@ -0,0 +1,3 @@
+vsyscall-int80.so
+vsyscall-sysenter.so
+vsyscall.lds
diff --git a/drivers/ieee1394/.gitignore b/drivers/ieee1394/.gitignore
new file mode 100644
index 0000000..33da10a
--- /dev/null
+++ b/drivers/ieee1394/.gitignore
@@ -0,0 +1 @@
+oui.c
diff --git a/drivers/scsi/aic7xxx/.gitignore b/drivers/scsi/aic7xxx/.gitignore
new file mode 100644
index 0000000..a1a7fcd
--- /dev/null
+++ b/drivers/scsi/aic7xxx/.gitignore
@@ -0,0 +1,4 @@
+aic79xx_reg.h
+aic79xx_seq.h
+aic7xxx_reg.h
+aic7xxx_seq.h
diff --git a/include/asm-i386/.gitignore b/include/asm-i386/.gitignore
new file mode 100644
index 0000000..62b0ac8
--- /dev/null
+++ b/include/asm-i386/.gitignore
@@ -0,0 +1 @@
+asm-offsets.h
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 2dac344..8298ca8 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -14,3 +14,4 @@ mconf
 qconf
 gconf
 kxgettext
+zconf.hash.c
-- 
1.2.4


--=-+Imm101Ts9e581ScjeOW
Content-Disposition: attachment; filename=0003-More-ignore-files-for-build-outputs.txt
Content-Type: text/plain; name=0003-More-ignore-files-for-build-outputs.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

>From nobody Mon Sep 17 00:00:00 2001
From: Matt McCutchen <matt@mattlaptop.metaesthetics.net>
Date: Sun Mar 5 23:12:19 2006 -0500
Subject: [PATCH] More ignore files for build outputs

---

 arch/i386/boot/.gitignore       |    3 +++
 arch/i386/boot/tools/.gitignore |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 arch/i386/boot/.gitignore
 create mode 100644 arch/i386/boot/tools/.gitignore

94eb588607845f97f0fceb6e95690142ba8a807a
diff --git a/arch/i386/boot/.gitignore b/arch/i386/boot/.gitignore
new file mode 100644
index 0000000..495f20c
--- /dev/null
+++ b/arch/i386/boot/.gitignore
@@ -0,0 +1,3 @@
+bootsect
+bzImage
+setup
diff --git a/arch/i386/boot/tools/.gitignore b/arch/i386/boot/tools/.gitignore
new file mode 100644
index 0000000..378eac2
--- /dev/null
+++ b/arch/i386/boot/tools/.gitignore
@@ -0,0 +1 @@
+build
-- 
1.2.4


--=-+Imm101Ts9e581ScjeOW
Content-Disposition: attachment; filename*0=0004-Fix-setlocalversion-to-follow-a-ref-when-looking-for-a-G; filename*1=IT-version-suffix.txt
Content-Type: text/plain; name*0=0004-Fix-setlocalversion-to-follow-a-ref-when-looking-for-a-GIT-v; name*1=ersion-suffix.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

>From nobody Mon Sep 17 00:00:00 2001
From: Matt McCutchen <matt@mattlaptop.metaesthetics.net>
Date: Sun Mar 5 23:16:01 2006 -0500
Subject: [PATCH] Fix setlocalversion to follow a `ref: ' when looking for a GIT version suffix

---

 scripts/setlocalversion |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

75f8f156ff1f7869b23edf795e9588e25755be5d
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 7c805c8..229bda7 100644
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -35,6 +35,13 @@ sub do_git_checks {
 	my $head = <H>;
 	chomp $head;
 	close(H);
+	# Follow a ref: in the HEAD
+	if ($head =~ s/^ref: //) {
+		open(H,"<.git/" . $head) or return;
+		$head = <H>;
+		chomp $head;
+		close(H);
+	}
 
 	opendir(D,".git/refs/tags") or return;
 	foreach my $tagfile (grep !/^\.{1,2}$/, readdir(D)) {
-- 
1.2.4


--=-+Imm101Ts9e581ScjeOW--
