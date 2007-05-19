From: david@lang.hm
Subject: Re: Using git to store /etc, redux
Date: Sat, 19 May 2007 16:37:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705191611150.6938@asgard.lang.hm>
References: <20070519174815.GA5124@hardeman.nu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1865333479-1179617874=:6938"
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
X-From: git-owner@vger.kernel.org Sun May 20 01:39:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpYVz-0008K0-FI
	for gcvg-git@gmane.org; Sun, 20 May 2007 01:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbXESXi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 19:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759249AbXESXi6
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 19:38:58 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:59475
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756AbXESXi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 19:38:57 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l4JNcoBS015022;
	Sat, 19 May 2007 16:38:50 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070519174815.GA5124@hardeman.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47783>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1865333479-1179617874=:6938
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 19 May 2007, David Härdeman wrote:

> I recently had the idea to store and track /etc using git. When googling the 
> topic I came across the "Using git to store /etc" thread from the end of last 
> year which provided some interesting details on what would be necessary.
>
> It seems the file metadata (owner, group, mode, xattrs, etc) was the big 
> stumbling point, so I wrote up a tool over the last few days which allows the 
> metadata to be stored in a separate file which can be stored along with the 
> rest of the data in the repo (or separately).
>
> This is also useful for tripwire type checks and for other types of storage 
> which drops some of the metadata (tar comes to mind)...
>
> The tool (metastore) is available from: git://git.hardeman.nu/metastore.git
>
> Not completely cleaned up yet (it lacks a real README and some Makefile 
> targets) but I hope it might be useful to others (it sure is to me).
>
> Please CC me on any replies.

as I understand the issue, the problem isn't creating a tool to store the 
metadata, but in integrating things with git.

when checking something in a pre-commit hook needs to run the tool to 
store the data.

git supports this and it's pretty simple to do this.

however when checking things out there are approaches

1. modify git to have a post-checkout hook to set the metadata to match
    what was stored at checkin and accept the fact that this leaves a
    window where the file has the wrong metadata on it (between when the
    file is written and when the hook runs), or use a staging area to have
    copies of the files during check-in and check-out

2. modify git to know that it needs to check some files out before any
    others and use an expernal program to write the files to disk. Then
    this program can use the data stored at checkin to write the files with
    the appropriate metadata

unforutnantly until one of these is done by someone the utility of 
programs like your metastore are limited.

David Lang
--680960-1865333479-1179617874=:6938--
