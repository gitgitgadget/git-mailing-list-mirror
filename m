From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Consolidate escaping/validation of query string
Date: Sun, 24 Sep 2006 14:21:21 +0200
Message-ID: <200609241421.21930.jnareb@gmail.com>
References: <20060923221841.18063.56589.stgit@rover> <ef4csl$7vk$1@sea.gmane.org> <20060924113613.GM20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 24 14:21:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSzN-0006es-LG
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 14:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWIXMVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 08:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWIXMVc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 08:21:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:38173 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750735AbWIXMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 08:21:32 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1320121nfa
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 05:21:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rapAgjkHRb+94preCc+LTr+CAyA6GoZTCz9RpqFIOi/rvRr5859jtqcg/+Dm4Ur8bjlLzavMwOYs6px+zsJ/WXdBSwoWsm9kA6ddjDnV2vn3L9yNffrFXmI6vQqmxlUUtnGB4TScgKelwVaT5OIaXbxwP9/xwlaoAU1VnyW/N1c=
Received: by 10.78.200.3 with SMTP id x3mr1089489huf;
        Sun, 24 Sep 2006 05:21:30 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id 4sm874918hue.2006.09.24.05.21.29;
        Sun, 24 Sep 2006 05:21:30 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060924113613.GM20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27665>

Petr "Pasky" Baudis wrote:
>>> I have also made esc_param() escape [?=&;]. Not escaping [&;] was downright
>>> buggy and [?=] just feels better escaped. ;-) YMMV.
> ..snip..
>> I'd rather have new esc_param() or esc_param_value() quote like escape
>> subroutine from CGI::Util, with the esception of _not_ escaping '/'
>> (it makes funny bookmark, and lot less readable query string), and rename
>> current esc_param() to esc_query_string() or esc_params().
> 
> Huh, well, what's the point with the rename and why not keep it as it is
> with just removing the four characters above? Escaped stuff looks ugly
> in a URL. ;-)

There are few places where we escape whole URL (so I'd prefer esc_url() for
current implementation): esc_param($home_link) and soon esc_param($githelp_url)
(and _not_ esc_html($githelp_url)). And those URLs can contain query strings,
so we cannot escape '?', ';' and '&', '=' there.

Before introduction of href() subroutine we escaped using esc_param the whole
query string, hence esc_param did not escaped [?=&;].
-- 
Jakub Narebski
Poland
