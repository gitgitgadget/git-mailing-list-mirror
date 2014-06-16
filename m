From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] unpack-trees: simplify via strnncmp()
Date: Mon, 16 Jun 2014 13:19:05 -0700
Message-ID: <20140616201905.GP8557@google.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
 <ee1716e209794a66eb9677e798164a356276700e.1402945507.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:19:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdN4-00017d-KE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbaFPUTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:19:10 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44646 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbaFPUTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:19:09 -0400
Received: by mail-pa0-f54.google.com with SMTP id et14so4836203pad.41
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u8bAurPxhn28vz91L2z3Yii5Bt+cg4XQoIYK5pro1n0=;
        b=UQJeoOoOxBP6uL3YB4WlBBheyLEnG56s/MWuVuD3wKNltRE7vr06RMbBrLAWkGqd5+
         LEUfP7vm+uMnC4epiiooic/QtuMyhW26g9/gWnIE1yojIDEEskAhbMB48LsA5EH2LlnZ
         J96CZoL55q/0DcQ3eDzV++GbXXtGHppwCYqwq/bSca61ftx4vMJBPDNxlQkXT3aER8V0
         edHg5PMO3Gn8ovyYtoIO97uU75O9j2uz6JTu7nJ0PfHLq+wqjWo9H8cPpZTCJHKLaeF3
         /aSkSZ1xx6CMiIHgjH+FVgnM7sHp3JnZwEViLj7EIeYgl+1iT2x5XDHJHb3xud9W2nsq
         YneQ==
X-Received: by 10.67.2.34 with SMTP id bl2mr26756974pad.58.1402949948429;
        Mon, 16 Jun 2014 13:19:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qv3sm20279817pbb.87.2014.06.16.13.19.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 13:19:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ee1716e209794a66eb9677e798164a356276700e.1402945507.git.jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251818>

Jeremiah Mahler wrote:

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
[...]
> @@ -678,7 +667,7 @@ static int find_cache_pos(struct traverse_info *info,
>  			ce_len = ce_slash - ce_name;
>  		else
>  			ce_len = ce_namelen(ce) - pfxlen;
> -		cmp = name_compare(p->path, p_len, ce_name, ce_len);
> +		cmp = strnncmp(p->path, p_len, ce_name, ce_len);

Likewise --- the sign of the result is important here.
