From: Christopher Beelby <chris@celabs.com>
Subject: git-gui PATCH Keep repo_config(gui.recentrepos) and .gitconfig in 
	synch
Date: Sat, 23 Jan 2010 14:21:48 -0500
Message-ID: <564f37c41001231121o10f88b6cwc35a126a0e79d3fc@mail.gmail.com>
References: <564f37c41001231118m3f253259g8876ac4fb2b927c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502b1c1fd203d047dd9d8e7
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 20:21:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYlYP-0000Np-Oe
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 20:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211Ab0AWTVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 14:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756151Ab0AWTVt
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 14:21:49 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47304 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab0AWTVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 14:21:49 -0500
Received: by pwi21 with SMTP id 21so1471978pwi.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 11:21:48 -0800 (PST)
Received: by 10.142.5.39 with SMTP id 39mr3152609wfe.81.1264274508685; Sat, 23 
	Jan 2010 11:21:48 -0800 (PST)
In-Reply-To: <564f37c41001231118m3f253259g8876ac4fb2b927c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137852>

--00504502b1c1fd203d047dd9d8e7
Content-Type: text/plain; charset=ISO-8859-1

This patch addresses two issues:

1. When the number of recent repo's gets to ten there can be a
situation where an item is removed from the .gitconfig file via
a call to git config --unset, but the internal representation of
that file (repo_config(gui.recentrepo)) is not updated. Then a
subsequent attempt to remove an item from the list fails because
git-gui attempts to call --unset on a value that has already been
removed. This leads to duplicates in the .gitconfig file, which
then also cause errors if the git-gui tries to --unset them (rather
than using --unset-all. --unset-all is not used because it is not
expected that duplicates should ever be allowed to exist.)

For complete step-by-step instructions on how to cause these situations
in git-gui see my comment on the msysgit project at
http://code.google.com/p/msysgit/issues/detail?id=362&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary#c9

2. When loading the list of recent repositories (proc _get_recentrepos)
if a repo in the list is not considered a valid git reposoitory
then we should go ahead and remove it so it doesn't take up a slot
in the list (since we limit to 10 items). This will prevent a bunch of
invalid entries in the list (which are not shown) from making valid
entries dissapear off the list even when there are less than ten valid
entries.

--00504502b1c1fd203d047dd9d8e7
Content-Type: application/octet-stream; name="patch1.patch"
Content-Disposition: attachment; filename="patch1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4ss58380

ZGlmZiAtLWdpdCBhL2dpdC1ndWkvbGliL2Nob29zZV9yZXBvc2l0b3J5LnRjbCBiL2dpdC1ndWkv
bGliL2Nob29zZV9yZXBvc2l0b3J5LnRjbAppbmRleCA2MzNjYzU3Li4zZjhmMzAzIDEwMDY0NAot
LS0gYS9naXQtZ3VpL2xpYi9jaG9vc2VfcmVwb3NpdG9yeS50Y2wKKysrIGIvZ2l0LWd1aS9saWIv
Y2hvb3NlX3JlcG9zaXRvcnkudGNsCkBAIC0yMzUsNiArMjM1LDggQEAgcHJvYyBfZ2V0X3JlY2Vu
dHJlcG9zIHt9IHsKIAlmb3JlYWNoIHAgW2dldF9jb25maWcgZ3VpLnJlY2VudHJlcG9dIHsKIAkJ
aWYge1tfaXNfZ2l0IFtmaWxlIGpvaW4gJHAgLmdpdF1dfSB7CiAJCQlsYXBwZW5kIHJlY2VudCAk
cAorCQl9IGVsc2UgeworCQkJX3Vuc2V0X3JlY2VudHJlcG8gJHAKIAkJfQogCX0KIAlyZXR1cm4g
W2xzb3J0ICRyZWNlbnRdCkBAIC0yNDMsNiArMjQ1LDcgQEAgcHJvYyBfZ2V0X3JlY2VudHJlcG9z
IHt9IHsKIHByb2MgX3Vuc2V0X3JlY2VudHJlcG8ge3B9IHsKIAlyZWdzdWIgLWFsbCAtLSB7KFso
KVxbXF17fVwuXiQrKj9cXF0pfSAkcCB7XFxcMX0gcAogCWdpdCBjb25maWcgLS1nbG9iYWwgLS11
bnNldCBndWkucmVjZW50cmVwbyAiXiRwXCQiCisJbG9hZF9jb25maWcgMQogfQogCiBwcm9jIF9h
cHBlbmRfcmVjZW50cmVwb3Mge3BhdGh9IHsKQEAgLTI2MSw2ICsyNjQsNyBAQCBwcm9jIF9hcHBl
bmRfcmVjZW50cmVwb3Mge3BhdGh9IHsKIAogCWxhcHBlbmQgcmVjZW50ICRwYXRoCiAJZ2l0IGNv
bmZpZyAtLWdsb2JhbCAtLWFkZCBndWkucmVjZW50cmVwbyAkcGF0aAorCWxvYWRfY29uZmlnIDEK
IAogCXdoaWxlIHtbbGxlbmd0aCAkcmVjZW50XSA+IDEwfSB7CiAJCV91bnNldF9yZWNlbnRyZXBv
IFtsaW5kZXggJHJlY2VudCAwXQo=
--00504502b1c1fd203d047dd9d8e7--
