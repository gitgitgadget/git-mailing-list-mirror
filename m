From: P Baker <me@retrodict.com>
Subject: [PATCH 2/2] Make git submodule --quiet summary obey flag
Date: Wed, 8 Apr 2009 03:05:19 -0400
Message-ID: <526944450904080005q115d17b4qcfc82239fc2e4b2d@mail.gmail.com>
References: <1239172707-38915-1-git-send-email-pbaker@retrodict.com>
	 <1239172707-38915-2-git-send-email-pbaker@retrodict.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 09:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRtS-0005RA-DQ
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 09:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbZDHHFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 03:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761996AbZDHHFW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 03:05:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:8098 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761901AbZDHHFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 03:05:20 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3434923qwh.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 00:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=frd63T7Fk7KULhrEbSceuud25rMrxN8T8sMmxJgPa2I=;
        b=Fd7K2Y3gmepdI2FS4vmbzcRw4yzy3V5Y+biV3fVwFF7iZX7CA/1lnEJbc5uwGWgZAS
         fXHZ0Nt2M/TzE0R8sq/uiCbzXvAUqx2HuUZ/bfG118YeHIxBQ2XHXx69l3I8U0W7omyv
         29xHlrbygvYzHSEst2+J2V0jrB7afXbarYfzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=skTmGLHiobMfu5NYnVW+j3ukVOK5D77jCwcGUmF0841/88xKlPcLB6Z6nDUDb4cH9V
         rHFbXPdYD4y9H/aW6GbXRTwzPPXKBoH2s54ifjBb37sjbv/1HqUnre+kDORfLN8rRWZV
         H6JbMUGQgJmJG9XLG0/lZjBJSFsyLzTQRLjug=
Received: by 10.220.76.144 with SMTP id c16mr1540923vck.17.1239174319256; Wed, 
	08 Apr 2009 00:05:19 -0700 (PDT)
In-Reply-To: <1239172707-38915-2-git-send-email-pbaker@retrodict.com>
X-Google-Sender-Auth: 3d5d7a9ec0185c5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116052>

Even with flag, summary would echo output. This patch conforms
git-submodule to match user expectations.

 Signed-off-by: pbaker <pbaker@retrodict.com>
 ---
  git-submodule.sh |   16 ++++++++--------
  1 files changed, 8 insertions(+), 8 deletions(-)

 diff --git a/git-submodule.sh b/git-submodule.sh
 index 7c2e060..784c6fa 100755
 --- a/git-submodule.sh
 +++ b/git-submodule.sh
 @@ -187,7 +187,7 @@ cmd_add()
        then
                if test -d "$path"/.git -o -f "$path"/.git
                then
 -                       echo "Adding existing repo at '$path' to the index"
 +                       say "Adding existing repo at '$path' to the index"
                else
                        die "'$path' already exists and is not a valid git repo"
                fi
 @@ -450,10 +450,10 @@ cmd_summary() {
                while read mod_src mod_dst sha1_src sha1_dst status name
                do
                        # Always show modules deleted or type-changed
(blob<->module)
 -                       test $status = D -o $status = T && echo
"$name" && continue
 +                       test $status = D -o $status = T && say
"$name" && continue
                        # Also show added or modified modules which
are checked out
                        GIT_DIR="$name/.git" git-rev-parse --git-dir
>/dev/null 2>&1 &&
 -                       echo "$name"
 +                       say "$name"
                done
        )

 @@ -522,25 +522,25 @@ cmd_summary() {
                        total_commits=" ($(($total_commits + 0)))"
                        ;;
                esac
 -
 +
                sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
                sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
                if test $status = T
                then
                        if test $mod_dst = 160000
                        then
 -                               echo "* $name
$sha1_abbr_src(blob)->$sha1_abbr_dst(submodule)$total_commits:"
 +                               say "* $name
$sha1_abbr_src(blob)->$sha1_abbr_dst(submodule)$total_commits:"
                        else
 -                               echo "* $name
$sha1_abbr_src(submodule)->$sha1_abbr_dst(blob)$total_commits:"
 +                               say "* $name
$sha1_abbr_src(submodule)->$sha1_abbr_dst(blob)$total_commits:"
                        fi
                else
 -                       echo "* $name
$sha1_abbr_src...$sha1_abbr_dst$total_commits:"
 +                       say "* $name
$sha1_abbr_src...$sha1_abbr_dst$total_commits:"
                fi
                if test -n "$errmsg"
                then
                        # Don't give error msg for modification whose
dst is not submodule
                        # i.e. deleted or changed to blob
 -                       test $mod_dst = 160000 && echo "$errmsg"
 +                       test $mod_dst = 160000 && echo >&2 "$errmsg"
                else
                        if test $mod_src = 160000 -a $mod_dst = 160000
                        then
 --
 1.6.2.1.316.gedbc2
