From: David Aguilar <davvid@gmail.com>
Subject: git-difftool
Date: Thu, 25 Dec 2008 17:30:23 -0800
Message-ID: <20081226013021.GA15414@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 02:41:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG1hs-0001d5-NC
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 02:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbYLZBgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 20:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbYLZBgP
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 20:36:15 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:30505 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbYLZBgN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 20:36:13 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3348630rvb.1
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=LUpBKs/itt2DZGLc9w+Ycirva6Neg+L7OR7n83CMlGU=;
        b=fPsJu8O+A5ySLipda766bJ2DBzQTSjZVTztU9dtb2p9PgXW+bFr7HNqWGN6cU0cqIx
         rYnEUVtei+yrVi1Ts963pgM6GhACr8KnY5h/6hymMa/9o9h120NI1aeXmjEpXWVOCuH0
         Pv7L8C03rKwe3/NveeowaCe+ZHcMw2TRdwG1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=wZlEadgtfy9n2FEsISK3sr3PsyTny4+9POQ4yKmK/QSnnuAYc3k1PW+uF9DJg46DXA
         yJjnBsEWM+vawUErzERdzeRGXWLcgHT9upcLBhHCZzKMUiiWhRhNpFqgOGIOKuF6XG9W
         ZA8Mggwbc1PXBPrbbVu2voG+Jwxg6CFhv2j/w=
Received: by 10.141.71.21 with SMTP id y21mr4269672rvk.0.1230255372949;
        Thu, 25 Dec 2008 17:36:12 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id b39sm16021881rvf.0.2008.12.25.17.36.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Dec 2008 17:36:12 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103918>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Several co-workers have found this script useful.
It's basically git-mergetool modified to operate on the git
index/worktree.  There's some things about the script that
aren't very gitish (for example, the way revargs are
processed) but it's useful nonetheless.

The usual use case for this script is when you have either
staged or unstaged changes and you'd like to see the changes
in a side-by-side diff viewer (e.g. xxdiff, tkdiff, etc).

	git difftool [<filename>*]

Another use case is when you'd like to see the same
information but are comparing arbitrary commits
(this is the part where the revarg parsing could be better)

	git difftool --start=HEAD^ --end=HEAD [-- <filename>*]

The last use case is when you'd like to compare your current
worktree to something other than HEAD (e.g. a tag)

	git difftool --commit=v1.0.0 [-- <filename>*]

It's a generally useful script so I thought I'd share it here.
If others find it useful then maybe we can fix it up and ship
it along with the other useful goodies in contrib/.


enjoy,

-- 

	David



--LQksG6bCIzRHxTLp
Content-Type: application/x-sh
Content-Disposition: attachment; filename="git-difftool.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A#=0A# This program uses merge tools to stage and compare commit=
s=0A#=0A# Copyright (c) 2008 David Aguilar=0A#=0A# Adapted from git-mergeto=
ol.sh=0A# Copyright (c) 2006 Theodore Y. Ts'o=0A#=0A# This file is licensed=
 under the GPL v2, or a later version=0A#=0AUSAGE=3D'=0A[--tool=3Dtool] [--=
no-prompt]=0A[--commit=3Dref] [--start=3Dref --end=3Dref]=0A[--] [file to v=
iew] ...'=0ASUBDIRECTORY_OK=3DYes=0AOPTIONS_SPEC=3D=0A# git-sh-setup is no =
longer in $PATH as of git 1.6.0=0APATH=3D"$(git --exec-path)":"$PATH"=0A. g=
it-sh-setup=0Arequire_work_tree=0Acd_to_toplevel=0A=0Akeep_backup_mode=3D"$=
(git config --bool merge.keepBackup || echo true)"=0APREFIX=3D.git-difftool=
=2E"$$"."$(date +%N)".=0AFILEDIR=3D=0A=0Akeep_backup () {=0A	# whether to k=
eep the .orig file=0A	test "$keep_backup_mode" =3D "true"=0A}=0A=0Aparse_ar=
g () {=0A	# parses --foo=3DBAR=0A	expr "z$1" : 'z-[^=3D]*=3D\(.*\)'=0A}=0A=
=0Aindex_present () {=0A	#  does the index contain staged changes?=0A	test =
-n "$index_mode"=0A}=0A=0Amodified_present () {=0A	# are there changes in t=
he requested comparison?=0A	test -n "$modified_mode"=0A}=0A=0Acommitish_pre=
sent () {=0A	# are we comparing against an arbitrary commit?=0A	test -n "$c=
ommitish"=0A}=0A=0Ashould_prompt () {=0A	# are we running interactively?=0A=
	! test -n "$no_prompt"=0A}=0A=0Ause_rev_range () {=0A	# are we using --sta=
rt=3DREF and --end=3DREF=0A	test -n "$start" && test -n "$end"=0A}=0A=0Amer=
ge_dir_missing () {=0A	# does dirname($MERGED) exist in the work tree?=0A	t=
est -n "$non_existant_dir"=0A}=0A=0Abase_present () {=0A	# whether we have =
3 things to compare (index, worktree, other)=0A	index_present && modified_p=
resent && ! use_rev_range=0A}=0A=0Amodified_files () {=0A	# returns the app=
opriate list of differences based on the mode=0A	if use_rev_range; then=0A	=
	git diff --name-only "$start".."$end" -- "$@" 2>/dev/null=0A	elif commitis=
h_present; then=0A		git diff --name-only "$commitish" -- "$@" 2>/dev/null=
=0A	else=0A		git diff --name-only -- "$@" 2>/dev/null=0A	fi=0A}=0A=0Astaged=
_files() {=0A	# returns any staged changes=0A	git diff --name-only --cached=
 "$@" 2>/dev/null=0A}=0A=0Acleanup_temp_files () {=0A	# removes temporary f=
iles=0A	if test -n "$MERGED"; then=0A		if keep_backup && test "$MERGED" -nt=
 "$BACKUP"; then=0A			test -f "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"=
=0A			rm -f -- "$LOCAL" "$REMOTE" "$BASE"=0A		else=0A			rm -f -- "$LOCAL" "=
$REMOTE" "$BASE" "$BACKUP"=0A		fi=0A		test -n "$MERGEDIR" && rmdir -p "$MER=
GEDIR"=0A	fi=0A}=0A=0Asigint_handler () {=0A	echo=0A	cleanup_temp_files=0A	=
exit 1=0A}=0A=0Amerge_file () {=0A	# prepares temporary files and launches =
the appropriate merge tool=0A	MERGED=3D"$1"=0A=0A	modified_mode=3D$(modifie=
d_files "$MERGED")=0A	index_mode=3D$(staged_files "$MERGED")=0A=0A	if ! mod=
ified_present && use_rev_range; then=0A		echo "$MERGED: no changes between =
'$start' and '$end'."=0A		exit 1=0A	elif ! modified_present && ! index_pres=
ent; then=0A		if ! test -f "$MERGED"; then=0A			echo "$MERGED: file not fou=
nd"=0A		else=0A			echo "$MERGED: file is unchanged."=0A		fi=0A		exit 1=0A	f=
i=0A=0A	# handle comparing a file that doesn't exist in the current checkou=
t=0A	MERGEDIR=3D$(dirname "$MERGED")=0A	non_existant_dir=3D=0A	test -d "$ME=
RGEDIR" || non_existant_dir=3Dtrue=0A	if merge_dir_missing; then=0A		mkdir =
-p -- "$MERGEDIR"=0A	else=0A		MERGEDIR=3D=0A	fi=0A=0A	ext=3D"$$$(expr "$MER=
GED" : '.*\(\.[^/]*\)$')"=0A	BACKUP=3D"./$MERGED.BACKUP.$ext"=0A	test -f "$=
MERGED" && cp -- "$MERGED" "$BACKUP"=0A=0A	if use_rev_range; then=0A		# we'=
re comparing two arbitrary commits=0A		BASE=3D"./$MERGED.CURRENT.$ext"=0A		=
LOCAL=3D"./$MERGED.START.$ext"=0A		REMOTE=3D"./$MERGED.END.$ext"=0A		base=
=3Dcurrent=0A		local=3Dstart=0A		remote=3Dend=0A		touch "$BASE"=0A		touch "=
$LOCAL"=0A		touch "$REMOTE"=0A=0A		# detects renames.. sweet!=0A		oldname=
=3D$(git diff --no-color --follow "$start".."$end" -- "$MERGED" |=0A			head=
 -n9 |=0A			grep '^rename from' |=0A			sed -e 's/rename from //')=0A		start=
name=3D"$MERGED"=0A		test -n "$oldname" && startname=3D"$oldname"=0A=0A		if=
 ! git show "$start":"$startname" > "$LOCAL" 2>/dev/null; then=0A			if shou=
ld_prompt; then=0A				printf "\nWarning: "=0A				printf "'$startname' does =
not exist at $start.\n"=0A			fi=0A		else=0A			cp -- "$LOCAL" "$BASE"=0A		fi=
=0A		if ! git show "$end":"$MERGED" > "$REMOTE" 2>/dev/null; then=0A			if s=
hould_prompt; then=0A				printf "\nWarning: "=0A				printf "'$MERGED' does =
not exist at $end.\n"=0A			fi=0A		else=0A			! test -f "$BASE" && cp -- "$RE=
MOTE" "$BASE"=0A		fi=0A=0A		# $BASE could be used by custom mergetool comma=
nds=0A		if test -f "$MERGED"; then=0A			cp -- "$MERGED" "$BASE"=0A		fi=0A	e=
lse=0A		# We're either comparing against the index or an=0A		# arbitrary co=
mmit.=0A		# The goal is to re-use existing mergetool.$tool.cmd=0A		# config=
urations so we provide $BASE $LOCAL and $REMOTE=0A		if commitish_present; t=
hen=0A			HEAD=3DOTHER=0A			local=3DOther=0A		else=0A			HEAD=3DHEAD=0A			loc=
al=3DIndex=0A		fi=0A		base=3D${commitish-HEAD}=0A		remote=3DCurrent=0A		BAS=
E=3D"./$MERGED.$HEAD.$ext"=0A		LOCAL=3D"./$MERGED.INDEX.$ext"=0A		REMOTE=3D=
"./$MERGED.CURRENT.$ext"=0A		touch "$BASE"=0A		touch "$LOCAL"=0A		touch "$R=
EMOTE"=0A		if ! git show "$base":"$MERGED" > "$BASE" 2>&1; then=0A			printf=
 "\nWarning: "=0A			printf "'$MERGED' does not exist at $base.\n"=0A		else=
=0A			cp "$BASE" "$LOCAL"=0A			if commitish_present; then=0A				rm -f "$LOC=
AL"=0A				LOCAL=3D"$BASE"=0A			fi=0A		fi=0A		# If changes are present in th=
e index use them as $LOCAL=0A		# but only if $MERGED exists at $base=0A		if=
 ! commitish_present; then=0A			git checkout-index --prefix=3D"$PREFIX" "$M=
ERGED"=0A			if test -f "$PREFIX""$MERGED"; then=0A				mv -- "$PREFIX""$MERG=
ED" "$LOCAL"=0A				tmpdir=3D$(dirname "$PREFIX""$MERGED")=0A				test -d "$t=
mpdir" &&=0A				test "$tmpdir" !=3D "." &&=0A				rmdir -p "$tmpdir"=0A			el=
se=0A				index_mode=3D=0A			fi=0A		else=0A			index_mode=3D=0A		fi=0A		if te=
st -f "$MERGED"; then=0A			cp -- "$MERGED" "$REMOTE"=0A		fi=0A	fi=0A=0A	# e=
nsure that we clean up after ourselves=0A	trap sigint_handler SIGINT=0A=0A	=
if should_prompt; then=0A		printf "\nEditing: '$MERGED'\n"=0A		printf "Hit =
return to launch '%s': " "$merge_tool"=0A		read ans=0A	fi=0A=0A	case "$merg=
e_tool" in=0A	kdiff3)=0A		basename=3D$(basename "$MERGED")=0A		if base_pres=
ent; then=0A		(=0A			"$merge_tool_path" --auto \=0A				--L1 "($base) $basen=
ame" \=0A				--L2 "($local) $basename" \=0A				--L3 "($remote) $basename" \=
=0A				-o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" \=0A				> /dev/null 2>&1=0A	=
	)=0A		else=0A		(=0A			"$merge_tool_path" --auto \=0A				--L1 "($local) $ba=
sename" \=0A				--L2 "($remote) $basename" \=0A				-o "$MERGED" "$LOCAL" "$=
REMOTE" \=0A				> /dev/null 2>&1=0A		)=0A		fi=0A		;;=0A=0A	tkdiff)=0A		if b=
ase_present; then=0A			"$merge_tool_path" \=0A				-a "$BASE" \=0A				-o "$M=
ERGED" "$LOCAL" "$REMOTE"=0A		else=0A			"$merge_tool_path" \=0A				-o "$MER=
GED" "$LOCAL" "$REMOTE"=0A		fi=0A		;;=0A=0A	meld)=0A		"$merge_tool_path" "$=
LOCAL" "$MERGED"=0A		;;=0A=0A	vimdiff)=0A		if base_present; then=0A			"$mer=
ge_tool_path" "$BASE" "$LOCAL" "$MERGED"=0A		else=0A			"$merge_tool_path" "=
$LOCAL" "$MERGED"=0A		fi=0A		;;=0A=0A	gvimdiff)=0A		if base_present; then=
=0A			"$merge_tool_path" -f "$BASE" "$LOCAL" "$MERGED"=0A		else=0A			"$merg=
e_tool_path" -f "$LOCAL" "$MERGED"=0A		fi=0A		;;=0A=0A	xxdiff)=0A		if base_=
present; then=0A			"$merge_tool_path" -X --show-merged-pane \=0A				-R 'Acc=
el.SaveAsMerged: "Ctrl-S"' \=0A				-R 'Accel.Search: "Ctrl+F"' \=0A				-R '=
Accel.SearchForward: "Ctrl-G"' \=0A				--merged-file "$MERGED" \=0A				"$BA=
SE" "$LOCAL" "$REMOTE"=0A		else=0A			"$merge_tool_path" -X --show-merged-pa=
ne \=0A				-R 'Accel.SaveAsMerged: "Ctrl-S"' \=0A				-R 'Accel.Search: "Ctr=
l+F"' \=0A				-R 'Accel.SearchForward: "Ctrl-G"' \=0A				--merged-file "$ME=
RGED" \=0A				"$LOCAL" "$REMOTE"=0A		fi=0A		;;=0A=0A	opendiff)=0A		if base_=
present; then=0A			"$merge_tool_path" "$LOCAL" "$REMOTE" \=0A				-ancestor =
"$BASE" \=0A				-merge "$MERGED" | cat=0A		else=0A			"$merge_tool_path" "$L=
OCAL" "$REMOTE" \=0A				-merge "$MERGED" | cat=0A		fi=0A		;;=0A=0A	ecmerge)=
=0A		if base_present; then=0A			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOT=
E" \=0A				--default --mode=3Dmerge3 --to=3D"$MERGED"=0A		else=0A			"$merge=
_tool_path" "$LOCAL" "$REMOTE" \=0A				--default --mode=3Dmerge2 --to=3D"$M=
ERGED"=0A		fi=0A		;;=0A=0A	emerge)=0A		if base_present; then=0A			"$merge_t=
ool_path" \=0A				-f emerge-files-with-ancestor-command \=0A				"$LOCAL" "$=
REMOTE" "$BASE" \=0A				"$(basename "$MERGED")"=0A		else=0A			"$merge_tool_=
path" -f emerge-files-command \=0A				"$LOCAL" "$REMOTE" "$(basename "$MERG=
ED")"=0A		fi=0A		;;=0A	*)=0A		if test -n "$merge_tool_cmd"; then=0A			if te=
st "$merge_tool_trust_exit_code" =3D "false"; then=0A				( eval $merge_tool=
_cmd )=0A			else=0A				( eval $merge_tool_cmd )=0A			fi=0A		fi=0A		;;=0A	es=
ac=0A	cleanup_temp_files=0A}=0A=0Awhile test $# !=3D 0=0Ado=0A	case "$1" in=
=0A	-t|--tool*)=0A		case "$#,$1" in=0A		*,*=3D*)=0A			merge_tool=3D$(parse_=
arg "$1")=0A			shift=0A			;;=0A		1,*)=0A			usage=0A			;;=0A		*)=0A			shift=
=0A			merge_tool=3D"$1"=0A			shift=0A			;;=0A		esac=0A		;;=0A	-c|--commit*)=
=0A		case "$#,$1" in=0A		*,*=3D*)=0A			commitish=3D$(parse_arg "$1")=0A			s=
hift=0A			;;=0A		1,*)=0A			usage=0A			;;=0A		*)=0A			shift=0A			commitish=
=3D"$1"=0A			shift=0A			;;=0A		esac=0A		;;=0A	-s|--start*)=0A		case "$#,$1"=
 in=0A		*,*=3D*)=0A			start=3D$(parse_arg "$1")=0A			shift=0A			;;=0A		1,*)=
=0A			usage=0A			;;=0A		*)=0A			shift=0A			start=3D"$1"=0A			shift=0A			;;=
=0A		esac=0A		;;=0A	-e|--end*)=0A		case "$#,$1" in=0A		*,*=3D*)=0A			end=3D=
$(parse_arg "$1")=0A			shift=0A			;;=0A		1,*)=0A			usage=0A			;;=0A		*)=0A	=
		shift=0A			end=3D"$1"=0A			shift=0A			;;=0A		esac=0A		;;=0A	--no-prompt)=
=0A		no_prompt=3Dtrue=0A		shift=0A		;;=0A	--)=0A		shift=0A		break=0A		;;=0A=
	-*)=0A		usage=0A		;;=0A	*)=0A		break=0A		;;=0A	esac=0Adone=0A=0Avalid_cust=
om_tool() {=0A	merge_tool_cmd=3D"$(git config mergetool.$1.cmd)"=0A	test -n=
 "$merge_tool_cmd"=0A}=0A=0Avalid_tool() {=0A	case "$1" in=0A	kdiff3 | tkdi=
ff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)=0A		=
;; # happy=0A	*)=0A		if ! valid_custom_tool "$1"=0A		then=0A			return 1=0A	=
	fi=0A		;;=0A	esac=0A}=0A=0Ainit_merge_tool_path() {=0A	merge_tool_path=3D$=
(git config mergetool."$1".path)=0A	if test -z "$merge_tool_path"; then=0A	=
	case "$1" in=0A		emerge)=0A			merge_tool_path=3Demacs=0A			;;=0A		*)=0A			=
merge_tool_path=3D"$1"=0A			;;=0A		esac=0A	fi=0A}=0A=0A=0Aif test -z "$merg=
e_tool"; then=0A	merge_tool=3D$(git config merge.tool)=0A	if test -n "$merg=
e_tool" && ! valid_tool "$merge_tool"; then=0A		echo >&2 "git config option=
 merge.tool set to unknown tool: $merge_tool"=0A		echo >&2 "Resetting to de=
fault..."=0A		unset merge_tool=0A	fi=0Afi=0A=0Aif test -z "$merge_tool"; th=
en=0A	if test -n "$DISPLAY"; then=0A		merge_tool_candidates=3D"kdiff3 tkdif=
f xxdiff meld gvimdiff"=0A		if test -n "$GNOME_DESKTOP_SESSION_ID"; then=0A=
			merge_tool_candidates=3D"meld $merge_tool_candidates"=0A		fi=0A		if test=
 "$KDE_FULL_SESSION" =3D "true"; then=0A			merge_tool_candidates=3D"kdiff3 =
$merge_tool_candidates"=0A		fi=0A	fi=0A=0A	if echo "${VISUAL:-$EDITOR}" | g=
rep 'emacs' > /dev/null 2>&1; then=0A		merge_tool_candidates=3D"$merge_tool=
_candidates emerge"=0A	fi=0A=0A	if echo "${VISUAL:-$EDITOR}" | grep 'vim' >=
 /dev/null 2>&1; then=0A		merge_tool_candidates=3D"$merge_tool_candidates v=
imdiff"=0A	fi=0A=0A	merge_tool_candidates=3D"$merge_tool_candidates opendif=
f emerge vimdiff"=0A	echo "merge tool candidates: $merge_tool_candidates"=
=0A=0A	for i in $merge_tool_candidates=0A	do=0A		init_merge_tool_path $i=0A=
		if type "$merge_tool_path" > /dev/null 2>&1; then=0A			merge_tool=3D$i=0A=
			break=0A		fi=0A	done=0A=0A	if test -z "$merge_tool" ; then=0A		echo "No =
known merge resolution program available."=0A		exit 1=0A	fi=0A=0Aelse=0A	if=
 ! valid_tool "$merge_tool"; then=0A		echo >&2 "Unknown merge tool $merge_t=
ool"=0A		exit 1=0A	fi=0A=0A	init_merge_tool_path "$merge_tool"=0A=0A	if tes=
t -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then=
=0A		echo "The merge tool $merge_tool is not available as '$merge_tool_path=
'"=0A		exit 1=0A	fi=0A=0A	if ! test -z "$merge_tool_cmd"; then=0A		merge_to=
ol_trust_exit_code=3D"$(git config --bool mergetool.$merge_tool.trustExitCo=
de || echo false)"=0A	fi=0Afi=0A=0A=0Aif test $# -eq 0; then=0A	use_index=
=3D0=0A	files=3D$(modified_files)=0A=0A	if test -z "$files"; then=0A		use_i=
ndex=3D1=0A		files=3D$(staged_files)=0A	fi=0A=0A	if test -z "$files"; then=
=0A		echo "No modified files exist."=0A		exit 1=0A	fi=0A=0A=0A	if test $use=
_index -eq 0; then=0A		modified_files |=0A		while IFS=3D read i=0A		do=0A		=
	merge_file "$i" < /dev/tty > /dev/tty=0A		done=0A	elif ! use_rev_range; th=
en=0A		staged_files |=0A		while IFS=3D read i=0A		do=0A			merge_file "$i" <=
 /dev/tty > /dev/tty=0A		done=0A	else=0A		echo "Nothing to compare."=0A		ex=
it 1=0A	fi=0Aelse=0A	while test $# -gt 0=0A	do=0A		merge_file "$1"=0A		shif=
t=0A	done=0Afi=0Aexit 0=0A
--LQksG6bCIzRHxTLp--
