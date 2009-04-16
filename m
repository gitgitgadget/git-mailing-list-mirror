From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/5] archive: do not read .gitattributes in working 
	directory
Date: Thu, 16 Apr 2009 20:50:05 +1000
Message-ID: <fcaeb9bf0904160350m14dce828oe88bda6562d98f48@mail.gmail.com>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com> 
	<1239848917-14399-2-git-send-email-gitster@pobox.com> <1239848917-14399-3-git-send-email-gitster@pobox.com> 
	<1239848917-14399-4-git-send-email-gitster@pobox.com> <1239848917-14399-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd174888e8d020467a9d401
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 12:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuPCH-0003qE-9k
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 12:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbZDPKuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 06:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbZDPKuW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 06:50:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:35717 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbZDPKuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 06:50:21 -0400
Received: by wf-out-1314.google.com with SMTP id 29so345165wff.4
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=O4l7dC5jN8KnRooA9RUyG/whWEQirK5VJvWyTeR/qq4=;
        b=knYkjzZjDlZkGguDJqahrnM8LmPAIT9zst5w+08NQn+WqT8e3nxyCgyOG2Tjhu8eyi
         9CT49O70kh+X14qgK4g3yHAHC4PZ0PpNmOagZJ5VRztaNfI1BU3o/cd13eZYhFUyLnY8
         zoisTDWG4jhsJ2H8Xyz/XNjRpkkbcEcMUWPWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nmiX+c58ti+iCv1n7oFT0LGmXvTEJ7BqyHZH67iyABQzZxR1fuYmHnvGG0644VwLd1
         Byd5nV6PXaQmrpaCAoTqogL6eynyI59fwqd+BUZVwf8IJ0mbanSBtWEcAym25SCM6S73
         5mi79GM5sGZSAozrynsMd0tnxHbo62bTlkG/c=
Received: by 10.142.13.14 with SMTP id 14mr2019486wfm.52.1239879020087; Thu, 
	16 Apr 2009 03:50:20 -0700 (PDT)
In-Reply-To: <1239848917-14399-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116691>

--000e0cd174888e8d020467a9d401
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sorry I got distracted by Vista+x11 stuff and had not work on this.

2009/4/16 Junio C Hamano <gitster@pobox.com>:
> @@ -168,6 +171,22 @@ int write_archive_entries(struct archiver_args *args=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0context.args =3D args;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0context.write_entry =3D write_entry;
>
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Setup index and instruct attr to read inde=
x only
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (!args->worktree_attributes) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&opts, 0, sizeo=
f(opts));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.index_only =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.head_idx =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.src_index =3D &th=
e_index;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.dst_index =3D &th=
e_index;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.fn =3D oneway_mer=
ge;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_tree_desc(&t, arg=
s->tree->buffer, args->tree->size);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unpack_trees(1, &t=
, &opts))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_attr_set_direction=
(GIT_ATTR_INDEX, &the_index);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D =C2=A0read_tree_recursive(args->tree, =
args->base, args->baselen, 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0args->pathspec, write_archive_entry, &context);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D READ_TREE_RECURSIVE)

Squash the attached patch on top of this patch (I have yet to install
mutt), we may avoid a few possible lstat()s during unpack_trees(),
also less memory allocation.

I was thinking about loading .gitattributes inside write_archive_entry
too, to avoid calling read_tree_recursive twice, but it requires
.gitattributes to be traversed first. Won't work if there are files
.abc, .def...

If read_tree_recusive() expose its tree to read_tree_fn_t, we can then
look ahead and load .gitattributes, but that requires changing
read_tree_fn_t interface. I'll see if it's feasible to make a
customized read_tree_recusive() just for archive.c

Oh and a feature request (not really because I don't use it myself):
support submodules in "git archive", anyone?

> @@ -36,6 +36,14 @@ int cmd_tar_tree(int argc, const char **argv, const ch=
ar *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argc--;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 if (2 <=3D argc && !strcmp(argv[1], "--fix-attribu=
tes")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc--;
> + =C2=A0 =C2=A0 =C2=A0 }

Does this part needed? Gotta fix tar_tree_usage and git-tar-tree.txt
too. I'd vote remove it.
--=20
Duy

--000e0cd174888e8d020467a9d401
Content-Type: text/x-patch; charset=US-ASCII; name="attr-1.patch"
Content-Disposition: attachment; filename="attr-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftlbffj50

ZGlmZiAtLWdpdCBhL2FyY2hpdmUuYyBiL2FyY2hpdmUuYwppbmRleCAwY2U2MjhiLi5mNzlkMDA1
IDEwMDY0NAotLS0gYS9hcmNoaXZlLmMKKysrIGIvYXJjaGl2ZS5jCkBAIC0xNDcsMTIgKzE0Nywz
NCBAQCBzdGF0aWMgaW50IHdyaXRlX2FyY2hpdmVfZW50cnkoY29uc3QgdW5zaWduZWQgY2hhciAq
c2hhMSwgY29uc3QgY2hhciAqYmFzZSwKIAlyZXR1cm4gZXJyOwogfQogCitzdGF0aWMgaW50IHJl
YWRfZ2l0YXR0cl90b19pbmRleChjb25zdCB1bnNpZ25lZCBjaGFyICpzaGExLCBjb25zdCBjaGFy
ICpiYXNlLCBpbnQgYmFzZWxlbiwgY29uc3QgY2hhciAqcGF0aG5hbWUsIHVuc2lnbmVkIG1vZGUs
IGludCBzdGFnZSwgdm9pZCAqY29udGV4dCkKK3sKKwlzdHJ1Y3QgY2FjaGVfZW50cnkgKmNlOwor
CXVuc2lnbmVkIGludCBzaXplOworCWludCBsZW47CisJc3RhdGljIGludCBnaXRhdHRyX2xlbiA9
IDA7CisKKwlpZiAoU19JU0RJUihtb2RlKSkKKwkJcmV0dXJuIFJFQURfVFJFRV9SRUNVUlNJVkU7
CisKKwlsZW4gPSBzdHJsZW4ocGF0aG5hbWUpOworCWlmICghZ2l0YXR0cl9sZW4pCisJCWdpdGF0
dHJfbGVuID0gc3RybGVuKEdJVEFUVFJJQlVURVNfRklMRSk7CisJaWYgKGxlbiA8IGdpdGF0dHJf
bGVuIHx8IHN0cmNtcChwYXRobmFtZStsZW4tZ2l0YXR0cl9sZW4sIEdJVEFUVFJJQlVURVNfRklM
RSkpCisJCXJldHVybiAwOworCXNpemUgPSBjYWNoZV9lbnRyeV9zaXplKGxlbik7CisJY2UgPSB4
Y2FsbG9jKDEsIHNpemUpOworCWNlLT5jZV9tb2RlID0gY3JlYXRlX2NlX21vZGUobW9kZSk7CisJ
Y2UtPmNlX2ZsYWdzID0gY3JlYXRlX2NlX2ZsYWdzKGxlbiwgc3RhZ2UpOworCW1lbWNweShjZS0+
bmFtZSwgcGF0aG5hbWUsIGxlbisxKTsKKwloYXNoY3B5KGNlLT5zaGExLCBzaGExKTsKKwlyZXR1
cm4gYWRkX2NhY2hlX2VudHJ5KGNlLCBBRERfQ0FDSEVfT0tfVE9fQUREIHwgQUREX0NBQ0hFX1NL
SVBfREZDSEVDSyk7Cit9CisKIGludCB3cml0ZV9hcmNoaXZlX2VudHJpZXMoc3RydWN0IGFyY2hp
dmVyX2FyZ3MgKmFyZ3MsCiAJCXdyaXRlX2FyY2hpdmVfZW50cnlfZm5fdCB3cml0ZV9lbnRyeSkK
IHsKIAlzdHJ1Y3QgYXJjaGl2ZXJfY29udGV4dCBjb250ZXh0OwotCXN0cnVjdCB1bnBhY2tfdHJl
ZXNfb3B0aW9ucyBvcHRzOwotCXN0cnVjdCB0cmVlX2Rlc2MgdDsKIAlpbnQgZXJyOwogCiAJaWYg
KGFyZ3MtPmJhc2VsZW4gPiAwICYmIGFyZ3MtPmJhc2VbYXJncy0+YmFzZWxlbiAtIDFdID09ICcv
JykgewpAQCAtMTcwLDIwICsxOTIsOCBAQCBpbnQgd3JpdGVfYXJjaGl2ZV9lbnRyaWVzKHN0cnVj
dCBhcmNoaXZlcl9hcmdzICphcmdzLAogCiAJY29udGV4dC5hcmdzID0gYXJnczsKIAljb250ZXh0
LndyaXRlX2VudHJ5ID0gd3JpdGVfZW50cnk7Ci0KLQkvKgotCSAqIFNldHVwIGluZGV4IGFuZCBp
bnN0cnVjdCBhdHRyIHRvIHJlYWQgaW5kZXggb25seQotCSAqLwogCWlmICghYXJncy0+d29ya3Ry
ZWVfYXR0cmlidXRlcykgewotCQltZW1zZXQoJm9wdHMsIDAsIHNpemVvZihvcHRzKSk7Ci0JCW9w
dHMuaW5kZXhfb25seSA9IDE7Ci0JCW9wdHMuaGVhZF9pZHggPSAtMTsKLQkJb3B0cy5zcmNfaW5k
ZXggPSAmdGhlX2luZGV4OwotCQlvcHRzLmRzdF9pbmRleCA9ICZ0aGVfaW5kZXg7Ci0JCW9wdHMu
Zm4gPSBvbmV3YXlfbWVyZ2U7Ci0JCWluaXRfdHJlZV9kZXNjKCZ0LCBhcmdzLT50cmVlLT5idWZm
ZXIsIGFyZ3MtPnRyZWUtPnNpemUpOwotCQlpZiAodW5wYWNrX3RyZWVzKDEsICZ0LCAmb3B0cykp
Ci0JCQlyZXR1cm4gLTE7CisJCXJlYWRfdHJlZV9yZWN1cnNpdmUoYXJncy0+dHJlZSwgTlVMTCwg
MCwgMCwgTlVMTCwgcmVhZF9naXRhdHRyX3RvX2luZGV4LCBOVUxMKTsKIAkJZ2l0X2F0dHJfc2V0
X2RpcmVjdGlvbihHSVRfQVRUUl9JTkRFWCwgJnRoZV9pbmRleCk7CiAJfQogCg==
--000e0cd174888e8d020467a9d401--
