From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Wed, 21 Dec 2007 06:40:38 +0900
Message-ID: <200712202145.lBKLj7Fu015050@mi0.bluebottle.com>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	<7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	<20071218154211.GB12549@alea.gnuu.de>
	<7vabo7y762.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 22:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5T90-0005t3-HS
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 22:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574AbXLTVlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 16:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbXLTVlH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 16:41:07 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:38547 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbXLTVlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 16:41:05 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBKLj7Fu015050
	for <git@vger.kernel.org>; Thu, 20 Dec 2007 13:45:08 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=qkVNhitlibNkEv9llW3x7U4lV6sseQgbnWmYqmBu5KwhwIyi61XXD3+ymuCgWoSc/
	+Mguu1Y6OKa9umidemSZMTCz9ZipwKcArNtFoUfBoIJvYhdBnYr95fF/kUQTcbu
Received: from nanako3.mail.bluebottle.com ([211.140.192.186])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBKLenGq011137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 13:40:56 -0800
In-Reply-To: <7vabo7y762.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <b52adc1e7901ad4cd09478b46e382e80>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69019>

Quoting Junio C Hamano <gitster@pobox.com>:
> J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
>
>> When it should go quick why don't use an alias. git stash can print =
the
>> list and everyone who wants a quick stash can create an alias for th=
is.
>
> You are taking this completely backwards.  The stash mechanism is all
> about creating a quickie temporary pair of commits.  Anybody who want=
s
> otherwise can use alias or choose not to use stash at all.

You are of course right.  That was the reason I made=20
git-stash command behave that way in the first place.

But I see that some people on the list find this behavior=20
dangerous and I can understand their fears.  Until one=20
learns that one can go back to the state before running=20
git-stash by running "git-stash apply" soon after that,=20
it appears to one that the work is lost.

How about making this behavior configurable?

-- 8< --
[PATCH] Make "git stash" configurable

"git stash" without argument originally created an unnamed=20
stash, but some people felt this can be confusing to new=20
users.  This introduces config variable stash.quick to=20
control this behavior.

The variable can take one of three values: true, false, ask.

When set to "true", the command allows to create a quick=20
stash without any user interaction.  When set to "false",=20
the command shows the list of stash instead.  When set to=20
"ask", the command asks the user.

=46or the first time users, when the variable is not set,=20
the command helps the user to set it interactively.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>

---

 git-stash.sh |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
 1 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f16fd9c..4bb7134 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -192,6 +192,69 @@ apply_stash () {
 	fi
 }
=20
+allow_quick_stash () {
+=09
+	quick=3D$(git config stash.quick)
+	if test $? !=3D 0
+	then
+		if ! test -t 0 || ! test -t 1
+		then
+			return 0
+		fi
+=09
+		echo '
+*** First time users ***
+
+"git stash" can create an unnamed stash entry without user interaction=
=2E
+This is a quick way to save away your work in progress.  Some people
+find this behaviour confusing or dangerous to new users.  You can
+configure the command to list the existing stash entries instead.'
+	=09
+		while :
+		do
+			echo '
+Do you want the command without argument to always...
+
+1. Ask for confirmation
+2. Create an unnamed stash
+3. List existing stash entries
+'
+			printf 'Which one? [1/2/3] '
+			read reply
+			quick=3D
+			case "$reply" in
+			1|A*)	quick=3Dask ;;
+			2|C*)	quick=3Dtrue ;;
+			3|L*)	quick=3Dfalse ;;
+			*)	continue ;;
+			esac
+			break
+		done
+		git config stash.quick $quick
+		echo '
+You can reconfigure this by editing your $HOME/.gitconfig file'
+
+	fi
+=09
+	case "$quick" in
+	true)	return 0 ;;
+	false)	return 1 ;;
+	ask)	: do not return ;;
+	esac
+=09
+	if ! test -t 0 || ! test -t 1
+	then
+		return 0
+	fi
+=09
+	printf 'Do you want to create an unnamed stash? [Y/n] '
+	read reply
+	case "$reply" in
+	[nN]*)	return 1 ;;
+	*)	return 0 ;;
+	esac
+}
+
 # Main command set
 case "$1" in
 list)
@@ -226,11 +289,16 @@ create)
 	create_stash "$*" && echo "$w_commit"
 	;;
 *)
-	if test $# -eq 0
+	if test $# -ne 0
+	then
+		usage
+	fi
+	if allow_quick_stash
 	then
 		save_stash && git-reset --hard
 	else
-		usage
+		echo "*** Stash List ***"
+		list_stash
 	fi
 	;;
 esac
--
1.5.3.7

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ind out how you can get spam free email.
http://www.bluebottle.com/tag/3
