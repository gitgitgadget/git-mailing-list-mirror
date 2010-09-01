X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-filter-branch : LANG / LC_ALL = C breaks UTF-8 author names
Date: Tue, 31 Aug 2010 20:08:55 -0500
Message-ID: <20100901010855.GD22968@burratino>
References: <4C6E8109.5030202@leadformance.com>
 <20100820133244.GB15736@burratino>
 <4C6E86AA.2020903@leadformance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 1 Sep 2010 01:11:06 +0000 (UTC)
Cc: git@vger.kernel.org
To: Richard MICHAEL <rmichael@leadformance.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=b7cBzfWoSy0ZANHJqDVRbaaqCc1SnpqHgdjl1s2bHIM=;
        b=Ywd4R2ZAR7TtGCtcMXuASJ6LRjlc+6XdTZPl47E2iDUh1YoEpW1vxtKd4fosuLY5lR
         WCIwspTPfTbtAzZQLMDpjsKgqBi8lC/lE/1+37FEil0tS7+fGzN9IgspOAM8WP4gpB/s
         jtuZNxHwElZxnVbAsFUokJfMk7L2ryis8ucBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Uo3/0M3J1g6XxHwBkW4BBKLvgIy+qZvRRd0811ps39O8WEgdJ4tlP/dzPi9LlKG/Wg
         o0wKJRalVZS45XQhKlpKO2l4YXehYD7omyzZyo3LH0J2xr6h3/l4Io4ziseLK4O8u3bZ
         4ocZz0qUPsoiZf3Mh62JvcVFWf3+emcXNsVeU=
Content-Disposition: inline
In-Reply-To: <4C6E86AA.2020903@leadformance.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1Oqbqy-0004Cb-Oz
 for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 03:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751812Ab0IABKr convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 21:10:47 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62307 "EHLO
 mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751430Ab0IABKq convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 21:10:46 -0400
Received: by qwh6 with SMTP id 6so5805932qwh.19 for <git@vger.kernel.org>;
 Tue, 31 Aug 2010 18:10:46 -0700 (PDT)
Received: by 10.229.232.198 with SMTP id jv6mr4841051qcb.36.1283303445907;
 Tue, 31 Aug 2010 18:10:45 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176]) by
 mx.google.com with ESMTPS id l8sm10441006qck.6.2010.08.31.18.10.44
 (version=SSLv3 cipher=RC4-MD5); Tue, 31 Aug 2010 18:10:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org

Hi Richard,

Richard MICHAEL wrote:
>>Richard MICHAEL wrote:

>>> I am filtering our repo with git-filter-branch, but as the sed
>>> script runs with LANG=3DC LC_ALL=3DC (7 bit US ASCII), it dies on
>>> commits authored by our team members with accented names.
[...]
> What about special casing the bad sed (or whitelisting good sed)?
> Surely a hack, but would those of us with GNU or BSD would be happy.
> Which was the troublesome sed?

Sorry for the slow response.  The problematic sed is GNU sed from
MacPorts (I think).  Even with LC_ALL=3DC, .* no longer matches
arbitrary sequences of bytes with such sed: you can check yours with

 $ echo '=C3=A9tale' | LC_ALL=3DC sed 's/.*//'

Unfortunately I have not been able to reproduce it on Linux.  Debian
sed 4.2.1-7 and GNU sed v4.2.1-21-gc6d32f0 both produce the expected
result:

 $ echo '=C3=A9tale' | LC_ALL=3DC sed 's/.*//'
 $

> Unfortunately, it
> doesn't "die" well either; the 'export' shell var fails but it keeps
> processing commits.

Hmm, that sounds like a bug indeed.  Here is what the start to a fix
might look like, but I stopped early because it there's quite a lot of
sed usage in git that expects to be able to process arbitrary data
with short, newline-terminated lines (regardless of encoding).

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..34a5fa3 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -68,8 +68,8 @@ eval "$functions"
 # "author" or "committer
=20
 set_ident () {
-	lid=3D"$(echo "$1" | tr "[A-Z]" "[a-z]")"
-	uid=3D"$(echo "$1" | tr "[a-z]" "[A-Z]")"
+	lid=3D"$(echo "$1" | tr "[A-Z]" "[a-z]")" &&
+	uid=3D"$(echo "$1" | tr "[a-z]" "[A-Z]")" &&
 	pick_id_script=3D'
 		/^'$lid' /{
 			s/'\''/'\''\\'\'\''/g
@@ -90,9 +90,9 @@ set_ident () {
=20
 			q
 		}
-	'
+	' &&
=20
-	LANG=3DC LC_ALL=3DC sed -ne "$pick_id_script"
+	LANG=3DC LC_ALL=3DC sed -ne "$pick_id_script" &&
 	# Ensure non-empty id name.
 	echo "case \"\$GIT_${uid}_NAME\" in \"\") GIT_${uid}_NAME=3D\"\${GIT_=
${uid}_EMAIL%%@*}\" && export GIT_${uid}_NAME;; esac"
 }
@@ -322,9 +322,11 @@ while read commit parents; do
 	git cat-file commit "$commit" >../commit ||
 		die "Cannot read commit $commit"
=20
-	eval "$(set_ident AUTHOR <../commit)" ||
+	set_author=3D$(set_ident AUTHOR <../commit) &&
+	eval "$set_author" ||
 		die "setting author failed for commit $commit"
-	eval "$(set_ident COMMITTER <../commit)" ||
+	set_committer=3D$(set_ident COMMITTER <../commit) &&
+	eval "$set_committer" ||
 		die "setting committer failed for commit $commit"
 	eval "$filter_env" < /dev/null ||
 		die "env filter failed: $filter_env"
