From: bdowning@lavos.net (Brian Downing)
Subject: Re: Using kdiff3 to compare two different revisions of a folder
Date: Wed, 13 Feb 2008 11:44:28 -0600
Message-ID: <20080213174428.GN27535@lavos.net>
References: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 18:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPLfT-0002iq-9o
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 18:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743AbYBMRoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 12:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbYBMRoh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 12:44:37 -0500
Received: from mxsf07.insightbb.com ([74.128.0.77]:34865 "EHLO
	mxsf07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbYBMRog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 12:44:36 -0500
X-IronPort-AV: E=Sophos;i="4.25,347,1199682000"; 
   d="scan'208";a="245914707"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf07.insightbb.com with ESMTP; 13 Feb 2008 12:44:34 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAKy7skdKhvkY/2dsb2JhbACBWZA3m1Y
X-IronPort-AV: E=Sophos;i="4.25,347,1199682000"; 
   d="scan'208";a="116678309"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 13 Feb 2008 12:44:34 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 9AD37309F21; Wed, 13 Feb 2008 11:44:28 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73804>

On Tue, Feb 12, 2008 at 11:44:07PM -0200, Andr=E9 Goddard Rosa wrote:
>     I would like to use kdiff3 to compare some folder like "include"
> between two different revisions.
>     It would be something like "git diff v2.5:makefile HEAD:makefile"=
,
> but for an entire folder.
>=20
>     Kdiff3 give me a quick glance of its nice graphical output of the
> differences, without have to resort to looking/parsing 'git log'
> output.
>     For now, easiest way for me is to keep my tree replicated in two
> different folders pointing to different revisions then use it.
>=20
>     Is there a better way to do this kind of comparison?

Maybe you want something like this?  This uses kdiff3 to compare two
full commits, by extracting the changed files into a temporary location=
=2E
Modifying it so it can work with path limiters and/or take arguments
exactly like 'git diff' is left as an excercise for the reader.

-bcd

#!/bin/sh -e

# usage: git-kdiff3 commit1 commit2

SUBDIRECTORY_OK=3D1
=2E git-sh-setup
cd_to_toplevel

O=3D".git-kdiff3-tmp-$$"
list=3D"$O/list"
trap "rm -rf $O" 0
mkdir $O

git diff --name-only -z $1 $2 > $list

cat $list | xargs -0 git archive --prefix=3Da/ $1 | tar xf - -C $O
cat $list | xargs -0 git archive --prefix=3Db/ $2 | tar xf - -C $O

kdiff3 $O/a $O/b
