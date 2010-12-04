From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/8] svn-fe: Test script for handling of dumps with
 --deltas
Date: Sat, 4 Dec 2010 11:29:02 -0600
Message-ID: <20101204172902.GA28299@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
 <20101120193016.GJ17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 04 18:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POvvN-00032s-HN
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 18:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab0LDR3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 12:29:23 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:45036 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab0LDR3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 12:29:22 -0500
Received: by gwb20 with SMTP id 20so5420988gwb.1
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rvNHPztFqgvAbKSlX/gxHKJR+hkYdRfjwH1+1A4j4fM=;
        b=xTw7t11Z8a6D2mdVbRpHqHQwTaUT4wHkGyve32vK56FEfp0qN3DBTkA42Tm3qRVwrZ
         zC5033KZtsqq/Z5tbnNx2K3HzRgzoVhfcw/MBOjk5NwKmSB8McO6i6zoSfRt2buyQb84
         sFIvn/BUePjTSeMKm9bApn7bJj8YQfe/KiRzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IZuIBrjFFTSC5b+gqQwxfhFGsgcSvWeWQBPVxITx+Bo4JVk6Nb5TC/NhRJY7lQCrt9
         xji68dhAomyH1oNCjg/whi6SF4LxJ7CQi0uYlbMpFZFmEHPZpFQqo2BDjsHkpuWnop1o
         4lXJgbdoZlACp8dXPQ/KAr+Yv+L4mh8T9JVE8=
Received: by 10.91.11.3 with SMTP id o3mr5043906agi.148.1291483761434;
        Sat, 04 Dec 2010 09:29:21 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id b26sm3179470anb.33.2010.12.04.09.29.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Dec 2010 09:29:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120193016.GJ17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162898>

Jonathan Nieder wrote:

> +++ b/contrib/svn-fe/testme.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# Usage:
> +#	PATH=${git_src}/contrib/svn-fe:${git_src}/bin-wrappers:$PATH
> +#	testme.sh http://cvs2svn.tigris.org/svn/cvs2svn 10 test.git
> +set -e
> +: ${1?"URL?"}
> +: ${2?"How many revisions?"}
> +: ${3?"Git directory?"}
> +
> +git init --bare "$3"
> +rm -f "$3/backflow"
> +mkfifo "$3/backflow"
> +
> +svnrdump dump -r1:"$2" "$1" |
> +svn-fe 3<backflow |
> +GIT_DIR=$3 git fast-import --cat-blob-fd=3 3>backflow

In case someone was puzzled: backflow should be "$3/backflow" on these
last two lines.

I didn't notice at first because there was already a fifo available in
the cwd during testing.
