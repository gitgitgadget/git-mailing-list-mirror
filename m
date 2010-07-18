From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 18 Jul 2010 13:55:34 +0200
Message-ID: <201007181355.36691.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <20100717093006.GA11452@localhost> <20100718004347.GA8665@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 13:55:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaSTK-0004Dl-BF
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 13:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab0GRLzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 07:55:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48224 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab0GRLzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 07:55:48 -0400
Received: by fxm14 with SMTP id 14so1734055fxm.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XI3UvesCNh5/uoPo8JZIFZVp3omwpGJk+hlMcgsj82U=;
        b=nlOmGdU3s8UQ8PQDwJdvyKq+QcEai1KJzIe2vFKENQra7ZmOjJ7rTFzE87nh+krkcN
         ltJ8B8olHCLuOsN4AXt5rkj1BTNM48ujbs4hjFFucDC5geep4KqmlrLEdgn4If2otvUb
         sPSXYpv5CGAOxxqmUXFKgvw+N5NpgA9UhjDIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PPKQVPMCrp2hewixNehX6HEoGzIKTNKSOxyxH7nYxC7cU+sUOOfUPNNYKjPan54D8h
         TiNzn0sJ7jc7/O5RegOODNMvkOoFg3UwXD6FScrvEcBpm//GH+wcj/TevhOZOba90ud5
         T4UubUK0d6GGNVJwRK+0bLWA7Ej9OwH9Pr4Cs=
Received: by 10.223.115.194 with SMTP id j2mr2497178faq.47.1279454146704;
        Sun, 18 Jul 2010 04:55:46 -0700 (PDT)
Received: from [192.168.1.13] (abwa30.neoplus.adsl.tpnet.pl [83.8.224.30])
        by mx.google.com with ESMTPS id d15sm476884faa.1.2010.07.18.04.55.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 04:55:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100718004347.GA8665@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151205>

On Sun, 18 Jul 2010, Jonathan Nieder wrote:

> On the other hand, there are some hard policy questions:
> 
>  * Should pre-deletion commits expire more quickly?

I think you should have an option to configure expiration of reflogs
of deleted branches separately, just like there is currently a way to
configure longer expiration time of HEAD reflog, or for stash.

With this on low disk size / low quota machine you would be able to
turn this feature (this protection) off.
 
>  * What happens when you rename one branch to take on the
>    name of a deleted one?

The same as with D/F conflict.  If you rename branch 'foo' to 'bar',
you also rename its reflog, but logs/refs/heads/bar would not conflict
with reflog for deleted branch, logs/refs~/heads~/bar (if you had 
deleted branch 'bar').

>  * What happens when you create a new branch to take the
>    place of a deleted one?

It would either be the same as above, or it would get reflog from 
deleted branch.  The former would be better, if there was in git some 
command to resurrect deleted branch.
 
>  * Should refs outside the refs/heads/ namespace
>    (like refs/bisect/ and refs/original/) use the same
>    policy as refs/heads/?

I guess that expire policy should be configured per ref, or per 
namespace.  Perhaps gc.<pattern>.reflogExpireDeleted ?  But then
gc.<pattern>.reflogExpireUnreachableDeleted would be long name, as
if compensating for two-letter section name ;-)

-- 
Jakub Narebski
Poland
