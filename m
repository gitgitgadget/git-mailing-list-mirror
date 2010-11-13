From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Using a different index and HEAD
Date: Sat, 13 Nov 2010 14:21:46 -0600
Message-ID: <20101113202146.GA16920@burratino>
References: <20101113152906.GA24903@nibiru.local>
 <20101113160546.GA5535@burratino>
 <20101113194128.GA8878@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Enrico Weigelt <weigelt@metux.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 21:22:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHMce-0001xC-BW
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 21:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab0KMUWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 15:22:21 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59702 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab0KMUWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 15:22:20 -0500
Received: by gxk23 with SMTP id 23so2411420gxk.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MTgm32J7vTJO5JfkCW7PBAG3/hHO16NZqrAy1W3+RNw=;
        b=onARhl6Ji4WW3vdqlAvnT9+4ODJh7nT0uG5SSy9YJ6HmuHdFd8h87GL/ndfILZkQ7p
         kIbL6P+Q5D/FRFNwzkMaKKd7GIuISEh/KjR2YnwWod8yIetYNUWZOueMdqUiReZFL1Ck
         aDbZIhxGVXbZ0g6CWT9umW4GMCtzkHgfioDWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DkM7BgOkzDrDVFo1ZzX76qUSNPMxQ7nbreGVGBj/AkfyF+kgBYrcsX1A0Q5L/4OV2Q
         XtM3jq8KdtIs9Zo/sPa5GMUTUyiTva6uBelRicSs9YJ6eo8gICO8sXK2z/R5dcCQ7sSO
         NUHVpI73oXxHVwgfSOfOrufx8TZUzYgTYqV+k=
Received: by 10.91.201.13 with SMTP id d13mr740829agq.38.1289679739289;
        Sat, 13 Nov 2010 12:22:19 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 67sm3357161yhl.8.2010.11.13.12.22.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Nov 2010 12:22:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101113194128.GA8878@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161396>

Enrico Weigelt wrote:

> I didnt have time for a deeper look yet, but I'll try to explain
> my ideas a bit more:
>
> Suppose I choose to work on an branch "one" (which probably is
> synced to some remote). That will create some temporary (local)
> WIP branch, where
[...]
>              Now I click some "commit" button and it asks me what
> exactly to commit - I now can interactively selected changes to
> be committed (maybe even on single changelets within a file),
> they'll be squashed together (maybe involving some rebase magic)
> and an commit final commit object is created on the "one" branch.

Ah, that is completely different. :)  Your tools would be

	GIT_INDEX_FILE=$GIT_DIR/wip-index; export GIT_INDEX_FILE
	git update-index ...
	git write-tree
	git commit-tree ...
	git update-ref ...
	git read-tree ...

none of which touch HEAD except the second to last one.

See the list of "low-level commands (plumbing)" and examples in
contrib/examples for more details.
