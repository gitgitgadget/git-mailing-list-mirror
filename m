From: Tim Landscheidt <tim@tim-landscheidt.de>
Subject: Multiple --reference arguments to submodule add/update
Date: Wed, 07 Mar 2012 13:59:43 +0000
Organization: <URI:http://www.tim-landscheidt.de/>
Message-ID: <m3hay0ldf4.fsf@passepartout.tim-landscheidt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 15:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Hnp-0004wG-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 15:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494Ab2CGOZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 09:25:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:55021 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755602Ab2CGOZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 09:25:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S5Hnb-0004fD-HQ
	for git@vger.kernel.org; Wed, 07 Mar 2012 15:25:03 +0100
Received: from g231144011.adsl.alicedsl.de ([92.231.144.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 15:25:03 +0100
Received: from tim by g231144011.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 15:25:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: g231144011.adsl.alicedsl.de
Mail-Copies-To: never
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:q63WmdBZ6uP0ysart7Bb3doB2Lo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192453>

Hi,

with git 1.7.9.3.362.g71319:

| git submodule update --reference A --reference B --init

will only consider repository B.  This is due to git-submodule.sh's:

| [module_clone()]
|                 if test -n "$reference"
|                 then
|                         git-clone $quiet "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
|                 else
|                         git-clone $quiet -n "$url" "$path" --separate-git-dir "$gitdir"
|                 fi ||

| [cmd_add()]
|                 --reference)
|                         case "$2" in '') usage ;; esac
|                         reference="--reference=$2"
|                         shift
|                         ;;
|                 --reference=*)
|                         reference="$1"
|                         shift
|                         ;;

| [cmd_update()]
|                 --reference)
|                         case "$2" in '') usage ;; esac
|                         reference="--reference=$2"
|                         orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
|                         shift
|                         ;;
|                 --reference=*)
|                         reference="$1"
|                         ;;

It's trivial to fix this for trivial repository specifiers.
But for specifiers with white space, quote or shell meta
characters, my mind boggles :-).

  Has anyone a nice patch for this?

Tim
