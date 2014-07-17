From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Thu, 17 Jul 2014 15:10:56 -0700
Message-ID: <20140717221056.GO12427@google.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 00:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7ttI-00061D-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 00:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757909AbaGQWLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 18:11:00 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39158 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbaGQWK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 18:10:59 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3825596pde.23
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p/BBEITfLhQQMhB17V7RB3k8aFwxxZJ9jA35+YcKFf8=;
        b=Wc+StWuAjTmN96E+5Brr/yBeKNWaFYmhrIanoHm1pGpwaE1CiGn5Hx0sgiFZZhY1IO
         GbxijTxfO63dS8SHERVJFpeCFNeaPLdlYnDuunM51tS44zW7r+roDcFoVwGYmfPT1yTC
         OhSCUOeHusPcmC6naBe/sF7R7A+Q7YOWF7n3h3s6EplI9/iFGniW0Ymhv2Gt2xdvlRlp
         zzJvuaZdlqkfPTdkgoC8Nbeqz+nxE04G/9nJxrq/UBRg3wYzauGV4hyT8JJSif+6Xx5A
         e/0mps88vbdjmbVMwNRkIkws1ZA/LqM9g8L1L+cHmZNHY02fUEbNplPeCiUEvGw0Difj
         iR3Q==
X-Received: by 10.66.182.132 with SMTP id ee4mr295017pac.64.1405635058948;
        Thu, 17 Jul 2014 15:10:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:2ddc:e64:e8c9:79e3])
        by mx.google.com with ESMTPSA id kq10sm3506183pbc.90.2014.07.17.15.10.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 15:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253784>

Hi,

Kyle J. McKay wrote:

> When I then try to fetch using a "git://host/..." URL where "host"
> is an mDNS host name, the 0010 patch causes git to attempt to lookup
> a DNS SRV record on the non-mDNS regular DNS service (a violation of
> RFC 6762 [4] section 22) and this is what has to time out before the
> real fetch can start.

That patch uses res_query from libresolv to do the lookup.  It doesn't
know what DNS server to use and relies on system libraries to get it
right.

It was added to respond to a feature request within Debian but it is
intended to eventually go upstream.  I'm glad you found this issue
before that could happen. :)

Should git automatically disable the SRV lookups when it sees one of
the six domains named in RFC6762, or is there some system library call
that can use mDNS when appropriate automatically (or get partway there
without having to hard-code the domains)?

Thanks,
Jonathan
