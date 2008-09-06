From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb pathinfo improvements
Date: Sat, 6 Sep 2008 13:22:29 +0200
Message-ID: <200809061322.31094.jnareb@gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 13:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbvtM-0007fs-KK
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 13:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYIFLWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 07:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbYIFLWj
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 07:22:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:15012 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbYIFLWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 07:22:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so934908fgg.17
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eefJHHFDfql7c5pgO5lxmOuIZlBX1dqfLQnPt2Avnww=;
        b=Y72gNJ2b+/l0KEAeeKAEwsn295fnArItJyQqTUZx45RMCo+rcj51tOJgqJZaT7Fk//
         Vq3m8XXs8yj6a11aljDkAG5nhJ626Naomucao8a0DzpV24T3p9uDxbWcKm+pb/wMA3yF
         9EhZfiQeUpIPQA6dwZexwkqgpn+nFAqOgVkNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=J4nK15gWqqHYtTPk8ZxZ/tdO1xxE8ys9D0uy2pX7THAd1wznb/gKFhpGUFmW7v68wk
         UpkMbgjqlelFh03K4P5d0l4q6Hj+zMqVtWyYAaeossW4/nSGMHQtDKr2CIUOCX6tPDCn
         hnXt3/UH604ZTkv+uSqRGins7/TGs7e4buOFU=
Received: by 10.86.66.11 with SMTP id o11mr9593910fga.69.1220700155529;
        Sat, 06 Sep 2008 04:22:35 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.117])
        by mx.google.com with ESMTPS id d6sm2075205fga.2.2008.09.06.04.22.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Sep 2008 04:22:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95069>

Hi, Giuseppe!

I'm sorry for the delay in reviewing this series

On Wed, 3 September 2008, Giuseppe Bilotta wrote:
> 
> The following patchset improves on gitweb's support for PATH_INFO
> by supporting paths in the form project/action/[parent..]hash,
> both in generating them and in accepting them. The old path info
> style project/hash is still supported as long as it doesn't
> conflict with the new style
> 
> For those that prefer git trees to patch bombs, my git tree is
> available for gitweb browsing at http://git.oblomov.eu/git and for
> git cloning at git://git.oblomov.eu/git/git
> 
> The changes are very local to the PATH_INFO parsing and creation,
> so I hope they don't conflict with Lea's cache work.

Let me comment first on _intent_ of the patches, and on series as
a whole, before examining individual patches in detail.

Below there is table of contents / shortlog of this series, which I 
think is a good practice to include in cover letter describing the 
series:

Table of contents:
==================
 * [PATCH 1/5] gitweb: action in path with use_pathinfo
 * [PATCH 2/5] gitweb: use_pathinfo filenames start with /
 * [PATCH 3/5] gitweb: parse parent..current syntax from pathinfo
 * [PATCH 4/5] gitweb: use_pathinfo creates parent..current paths
 * [PATCH 5/5] gitweb: remove PATH_INFO from $my_url and $my_uri

This series of patches deal with moving more parameters from CGI query 
to pathinfo (beside 2nd and 5th, which are about relative navigation in 
HTML files ('blob_plain' view) and ability to act as DirectoryIndex, 
which means that they are about using gitweb as web server).

There are two sides of those pathinfo improvement: first is to be able 
to get more parameters from pathinfo, second is to use pathinfo-URLs
in gitweb links if requested/configured.

The problem with fitting more parameters in pathinfo is first backwards 
compatibility (this is not strict requirement, but we would rather not 
make existing bookmarked pathinfo URLs invalid), and second with 
ordering those parameters and detecting when one parameter ends and 
next one begins (which is made more complicated by the fact that some 
parameters, like action or hash/hash_base can be skipped).

This trouble with fitting parameters in pathinfo creates some 
limitations and tradeoffs. For example (optionally!) embedding
the action in the pathinfo, by putting it after project and before 
hash/hash_base (usually refname) and filename makes old-style 
$project/$branch lead to incorrect view. This also means that we have 
to be careful about creating pathinfo links, either by always putting 
an action, or using full ref name (which I think we do anyway to avoid 
tag/head ambiguities); or doing it only in the case of possible 
conflict i.e. branch named like one of gitweb actions.

Using ':' or ':/' to separate branch name (hash or hash_base) from 
filename doesn't lead to problems, as pathinfo is split on _first_ 
occurrence of ':', and refnames cannot contain ':'. Using '..' to 
separate $hash_parent_base:$file_parent from $hash_base:$filename
is IMVHO a very good idea... but when creating pathinfo links we have
to consider filenames with '..' in them; an example is there in git 
repository: "t/t5515/refs.master_.._.git" file. Then we probably want 
to fallback on CGI query/CGI parameters. NOTE: I have not read the 
patch yet, perhaps it does this.


By the way, this is perhaps slightly outside the issue of this series, 
but having a..b syntax would tempt to handcraft gitweb URLs for 
equivalents of "git log a..b", "git log a...b" and "git diff a...b",
neither of which works yet.

-- 
Jakub Narebski
Poland
