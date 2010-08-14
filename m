From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb not friendly to firefox revived
Date: Sat, 14 Aug 2010 14:29:35 +0200
Message-ID: <201008141429.36829.jnareb@gmail.com>
References: <20100801195138.GA1980@pengutronix.de> <201008032350.40117.jnareb@gmail.com> <4C6670EE.3060806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Uwe =?iso-8859-1?q?Kleine-K=F6nig?=" 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	kernel@pengutronix.de
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 14:29:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkFrY-0008Da-6J
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 14:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab0HNM3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 08:29:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60436 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab0HNM3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 08:29:03 -0400
Received: by bwz3 with SMTP id 3so1659452bwz.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xSdoSJn20cCfKneayNLUX5ARsjDY3xZz9xDMv0QsjAU=;
        b=GOBQ3aOL32iW0M2a6UuPc4UzGyEbcuWoXOQj8b1i8xc1pZsH27qIXjJKK3XcC9929i
         JzIFr+0QPtzNspXJyPle9mfQ14goRHLVzxzJatSGAOgj9Gr8b9LIjCbxi9py0zioa2NC
         Kcq0hjUQNZHh7J3ZfjHoa4+HvQ95e55PnFGz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ijOmYKpHLsW6TUb3z+L3xx07uGcmZ1dS8FKMiQO/dmog0Am/fdlMQ5k0WWloZKPK0Z
         5Q+QNvKhCYx2z+cY+L4ElYGWDApCcivZa8NtdPYo0fcuIzhWMjvI01O0Dfs/JaXMQe8b
         ZsnDiZI8JTkPBoG81F/CrcznzT0Ss6OmaDpTo=
Received: by 10.204.112.146 with SMTP id w18mr1660477bkp.16.1281788941076;
        Sat, 14 Aug 2010 05:29:01 -0700 (PDT)
Received: from [192.168.1.13] (abvh53.neoplus.adsl.tpnet.pl [83.8.205.53])
        by mx.google.com with ESMTPS id x19sm2512683bkv.9.2010.08.14.05.28.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 05:28:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C6670EE.3060806@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153555>

On Sat, 14 Aug 2010, Stephen Boyd wrote:
>   On 08/03/2010 02:50 PM, Jakub Narebski wrote:
> > +
> > +	my $title = to_utf8("Search for commits $performed by $author");
> > +	$title =~ s/[[:cntrl:]]/?/g;
> > +
> >
> 
> Isn't it possible that other data coming from git could have escape
> characters in them such as the commit subject line? In which case this
> same bug would occur?  
> 
> Therefore isn't it better to strip out control characters (that's what
> this patch is doing right?) in esc_html? 

First, esc_html and esc_path *do* escape control characters using
either control escape characters (e.g. "\n" for LF), or escaped octal 
representation (e.g. "\001").

Second, it does not help with contents of *attributes* of HTML tag 
elements (like e.g. 'title' attribute) when those elements are 
generated using CGI (e.g. $cgi->a({..., -title => ...},esc_html(...))).
Unfortunately (older?) CGI.pm does not escape control characters, and
we cannot do escape ourselves because it would lead to double escaping.


The problem with Firefox is that in strict XHTML conformance model 
(XHTML DTD and application/xhtml+xml mimetype) it *enforces* that XML
is well formed, which includes lack of control characters, instead of
silently allowing it like in more loose HTML mode.

-- 
Jakub Narebski
Poland
