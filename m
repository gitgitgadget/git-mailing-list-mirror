From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: generate project/action/hash URLs
Date: Sat, 4 Oct 2008 03:15:36 +0200
Message-ID: <200810040315.37662.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 03:33:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klw0s-00057b-9l
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 03:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbYJDBbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 21:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYJDBbi
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 21:31:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23111 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYJDBbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 21:31:38 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1370195ugf.37
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 18:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9UlrMI336mNNn0JDFwWISuK7I5MWz4CP4rekGjf6MnU=;
        b=orzdyhpzTe9O3Npgvdb2FwRARML58UjTwSCgmsPRm8GeiARfpmg9MLSP+KA3moRJeo
         riverf+BU2yE/AIC54gt+UZkmIFYlxADPLY2HfWEmd9uzwEiq+de8i/lT6vs5i++WyqY
         0F5qgygT1VtiBqZtb/wcNj5A1Hr/SVsxKjc2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pr29mHOHQgBYWOhGiwdKXKkKrv75W3Ela0CfFZpa2KJvnhGNapWDkfDQNiu7aw915b
         1xA/iv5Qtv8is7F+b+Td20dRDK+VptYJDSxeBiG++Og38PVfZLlULj0Gbe1exXNWv2k+
         SRYdNtblwAUd50mFBx2dApTSQt01wh7vHzYhA=
Received: by 10.67.95.4 with SMTP id x4mr5964363ugl.16.1223083896131;
        Fri, 03 Oct 2008 18:31:36 -0700 (PDT)
Received: from ?192.168.1.11? (abwi176.neoplus.adsl.tpnet.pl [83.8.232.176])
        by mx.google.com with ESMTPS id y7sm16918944ugc.2.2008.10.03.18.31.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 18:31:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97461>

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

> When generating path info URLs, reduce the number of CGI parameters by
> embedding action and hash_parent:filename or hash in the path.

I think this is good.

>---

> +		# Finally, we put either hash_base:file_name or hash
> +		if (defined $params{'hash_base'}) {
> +			$href .= "/".esc_url($params{'hash_base'});
> +			if (defined $params{'file_name'}) {
> +				$href .= ":".esc_url($params{'file_name'});
> +				delete $params{'file_name'};
> +			}
> +			delete $params{'hash'};
> +			delete $params{'hash_base'};
> +		} elsif (defined $params{'hash'}) {
> +			$href .= "/".esc_url($params{'hash'});
> +			delete $params{'hash'};
> +		}
>  	}

That I'm not sure about, both the layout of conditional (shouldn't
we check $file_name first), and the fact that we remove parameter
which is not passed, and can be even not recoverable (for example
both 'hash' and 'hash_base' set, 'hash' != 'hash_base', and
'file_name' not set).  So the code above probably has some strange
corner cases, but I guess it wouldn't be triggered by links generated
by gitweb.

But I guess that is "good enough", especially that 'tree' and 'history'
action links can have 'file_name' unset if they refer to top tree, and
they still need 'hash_base'.

-- 
Jakub Narebski
Poland
