From: Giulio Eulisse <Giulio.Eulisse@cern.ch>
Subject: [PATCH] git-submodule and --upload-pack
Date: Mon, 31 Aug 2009 15:52:07 +0200
Message-ID: <9D7140EC-EAFD-4408-93E3-0E756BA363DA@cern.ch>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 15:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi7I6-0004yU-CE
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 15:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbZHaNvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 09:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbZHaNvP
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 09:51:15 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:47596 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZHaNvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 09:51:14 -0400
Received: by ewy2 with SMTP id 2so326833ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=ujOXj/1SSS5StmfPgEJcmO8RcuC2eBzzuP8IEL8Cf5k=;
        b=fBgHLgmXLVQQLTrl/gpK7f8ud/u9AyO+xxYKXjcIFshehKNGSRnpe18tHkYktwO5LY
         13z6fL28NLvBG8453Ujj24qSCfnn3lbLCo/cHOd4BWoStqZoixEwifnNve5JkDIX0FO8
         uo3DmmFrO/FFLUt9WQBaTw5zTs5fXBck5xEG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=YlHfZWhfFhDBO+GucnGMtF62WlWxXPKzRLFxvGpvWRxrXkAbw7wXVSYi+dgmE+ZrHH
         LB2fAPgi/qYwyIE3JSf2o9sLlaBBGnwW9eCE5gb6Lnsgqd/DqyCNwRG7waS+/hdm/eY3
         C6vjd/NIyAAD2Xwwt7Kp5SsWwwNcOiRSmORPs=
Received: by 10.211.174.10 with SMTP id b10mr5377339ebp.39.1251726652911;
        Mon, 31 Aug 2009 06:50:52 -0700 (PDT)
Received: from iguana3.cern.ch (iguana3.cern.ch [137.138.52.211])
        by mx.google.com with ESMTPS id 10sm148918eyd.39.2009.08.31.06.50.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 06:50:52 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127483>

Ciao,

There was a thread a while ago aboyt having --upload-pack support for  
git-submodule.

Given that there was no followup (as far as I can tell) and I needed  
pretty much
the same functionality I ported Jason's patch to work on top of 1.6.4.2.

Comments?

Ciao,
Giulio
--

diff --git a/Documentation/git-submodule.txt b/Documentation/git- 
submodule.txt
index 683ba1a..50aa930 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,8 +9,8 @@ git-submodule - Initialize, update or inspect submodules
  SYNOPSIS
  --------
  [verse]
-'git submodule' [--quiet] add [-b branch]
-	      [--reference <repository>] [--] <repository> <path>
+'git submodule' [--quiet] add [-b branch]
+              [-u <git-upload-pack>] [--receive-pack <git-receive- 
pack>] [--reference <repository>] [--] <repository> <path>
  'git submodule' [--quiet] status [--cached] [--] [<path>...]
  'git submodule' [--quiet] init [--] [<path>...]
  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
@@ -164,6 +164,19 @@ OPTIONS
  --branch::
  	Branch of repository to add as submodule.

+--upload-pack <upload-pack>::
+-u <upload-pack>::
+	When given, and the repository to clone from is accessed
+	via ssh, this specifies a non-default path for the
+	'git-upload-pack' program on the remote end.  See
+	linkgit:git-fetch-pack[1].
+
+--receive-pack <receive-pack>::
+	When given, and the repository to clone from is accessed
+	via ssh, this specifies a non-default path for the
+	'git-receive-pack' program on the remote end.  See
+	linkgit:git-push[1].
+
  --cached::
  	This option is only valid for status and summary commands.  These
  	commands typically use the commit found in the submodule HEAD, but
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 5daf750..bf982a6 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -30,6 +30,14 @@ submodule.<name>.path::
  submodule.<name>.url::
  	Defines an url from where the submodule repository can be cloned.

+submodule.<name>.receivepack::
+	The default program to execute on the remote side when pushing.  See
+	option \--receive-pack of linkgit:git-push[1].
+
+submodule.<name>.uploadpack::
+	The default program to execute on the remote side when fetching.  See
+	option \--upload-pack of linkgit:git-fetch-pack[1].
+
  submodule.<name>.update::
  	Defines what to do when the submodule is updated by the superproject.
  	If 'checkout' (the default), the new commit specified in the
@@ -41,7 +49,6 @@ submodule.<name>.update::
  	This config option is overridden if 'git submodule update' is given
  	the '--merge' or '--rebase' options.

-
  EXAMPLES
  --------

@@ -53,12 +60,16 @@ Consider the following .gitmodules file:

  	[submodule "libbar"]
  		path = include/bar
-		url = git://bar.com/git/lib.git
+		url = ssh://bar.com/~/git/lib.git
+		uploadpack = /home/you/bin/git-upload-pack-wrapper
+		receivepack = /home/you/bin/git-receive-pack-wrapper


  This defines two submodules, `libfoo` and `libbar`. These are  
expected to
  be checked out in the paths 'include/foo' and 'include/bar', and for  
both
  submodules an url is specified which can be used for cloning the  
submodules.
+For `libbar`, packs are retrieved and stored via the upload and receive
+wrappers, respectively.

  SEE ALSO
  --------
diff --git a/git-submodule.sh b/git-submodule.sh
index ebed711..25edd59 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -82,6 +82,8 @@ module_clone()
  	path=$1
  	url=$2
  	reference="$3"
+        uploadpack=$4
+        receivepack=$5

  	# If there already is a directory at the submodule path,
  	# expect it to be empty (since that is the default checkout
@@ -97,13 +99,30 @@ module_clone()
  	test -e "$path" &&
  	die "A file already exist at path '$path'"

+        uploadpackCmd=""
+
+        if test "$uploadpack"
+        then
+          uploadpackCmd="--upload-pack $uploadpack"
+        fi
+
  	if test -n "$reference"
  	then
-		git-clone "$reference" -n "$url" "$path"
+		git-clone $uploadpackCmd "$reference" -n "$url" "$path"
  	else
-		git-clone -n "$url" "$path"
+		git-clone $uploadpackCmd -n "$url" "$path"
  	fi ||
  	die "Clone of '$url' into submodule path '$path' failed"
+	if test "$uploadpack"
+	then
+	    git config -f "${path}/.git/config" remote.origin.uploadpack  
"$uploadpack" ||
+	    echo "  Warn: Failed to set uploadpack for '$url' in submodule  
path '$path'."
+	fi
+	if test "$receivepack"
+	then
+	    git config -f "${path}/.git/config" remote.origin.receivepack  
"$receivepack" ||
+	    echo "  Warn: Failed to set receivepack for '$url' in submodule  
path '$path'."
+	fi
  }

  #
@@ -136,6 +155,16 @@ cmd_add()
  			reference="$1"
  			shift
  			;;
+		-u|--upload-pack)
+			case "$2" in '') usage ;; esac
+			uploadpack=$2
+			shift
+			;;
+		--receive-pack)
+			case "$2" in '') usage ;; esac
+			receivepack=$2
+			shift
+			;;
  		--)
  			shift
  			break
@@ -206,9 +235,17 @@ cmd_add()
  			;;
  		esac
  		git config submodule."$path".url "$url"
+		if test "$uploadpack"
+			then
+		    git config submodule."$path".uploadpack "$uploadpack"
+		fi
+		if test "$receivepack"
+		then
+		    git config submodule."$path".receivepack "$receivepack"
+		fi
  	else

-		module_clone "$path" "$realrepo" "$reference" || exit
+		module_clone "$path" "$realrepo" "$reference" "$uploadpack"  
"$receivepack" || exit
  		(
  			unset GIT_DIR
  			cd "$path" &&
@@ -224,7 +261,19 @@ cmd_add()
  	die "Failed to add submodule '$path'"

  	git config -f .gitmodules submodule."$path".path "$path" &&
-	git config -f .gitmodules submodule."$path".url "$repo" &&
+	git config -f .gitmodules submodule."$path".url "$repo" ||
+	die "Failed to register submodule '$path'"
+
+	if test "$uploadpack"
+        then
+	    git config -f .gitmodules submodule."$path".uploadpack  
"$uploadpack" ||
+	    die "Failed to register submodule '$path'"
+	fi
+	if test "$receivepack"
+        then
+	    git config -f .gitmodules submodule."$path".receivepack  
"$receivepack" ||
+	    die "Failed to register submodule '$path'"
+	fi
  	git add .gitmodules ||
  	die "Failed to register submodule '$path'"
  }
@@ -299,6 +348,19 @@ cmd_init()
  		git config submodule."$name".url "$url" ||
  		die "Failed to register url for submodule path '$path'"

+		uploadpack=$(git config -f .gitmodules submodule."$name".uploadpack)
+		receivepack=$(git config -f .gitmodules  
submodule."$name".receivepack)
+		if test "$uploadpack"
+		then
+		    git config submodule."$name".uploadpack "$uploadpack" ||
+		    echo "  Warn: Failed to set uploadpack for '$url' in submodule  
path '$path'."
+		fi
+		if test "$receivepack"
+		then
+		    git config submodule."$name".receivepack "$receivepack" ||
+		    echo "  Warn: Failed to set receivepack for '$url' in submodule  
path '$path'."
+		fi
+
  		upd="$(git config -f .gitmodules submodule."$name".update)"
  		test -z "$upd" ||
  		git config submodule."$name".update "$upd" ||
@@ -384,7 +446,8 @@ cmd_update()

  		if ! test -d "$path"/.git -o -f "$path"/.git
  		then
-			module_clone "$path" "$url" "$reference"|| exit
+			module_clone "$path" "$url" "$reference" "$(git config  
submodule."$name".uploadpack)" \
+                            "$(git config  
submodule."$name".receivepack)" || exit
  			subsha1=
  		else
  			subsha1=$(unset GIT_DIR; cd "$path" &&
@@ -738,6 +801,18 @@ cmd_sync()
  			remote=$(get_default_remote)
  			say "Synchronizing submodule url for '$name'"
  			git config remote."$remote".url "$url"
+			uploadpack=$(git config -f .gitmodules submodule."$name".uploadpack)
+			receivepack=$(git config -f .gitmodules  
submodule."$name".receivepack)
+			if test "$uploadpack"
+			then
+			    git config submodule."$name".uploadpack "$uploadpack" ||
+			    echo "  Warn: Failed to set uploadpack for '$url' in submodule  
path '$name'."
+			fi
+			if test "$receivepack"
+			then
+			    git config submodule."$name".receivepack "$receivepack" ||
+			    echo "  Warn: Failed to set receivepack for '$url' in  
submodule path '$name'."
+			fi
  		)
  		fi
  	done
