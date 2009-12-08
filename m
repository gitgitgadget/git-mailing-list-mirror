From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v4 2/6] reset: use "unpack_trees()" directly instead of
 "git read-tree"
Date: Tue, 08 Dec 2009 00:45:19 -0800
Message-ID: <1260261919.1554.11.camel@swboyd-laptop>
References: <20091208075005.4475.26582.chriscool@tuxfamily.org>
	 <20091208075616.4475.46720.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 09:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHvhK-0005yy-CT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 09:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZLHIpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 03:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZLHIpS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 03:45:18 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:50804 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZLHIpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 03:45:16 -0500
Received: by pzk1 with SMTP id 1so2005773pzk.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 00:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=87Oeyjp2C2qd5kpEjRZbarYerXk7R2uGmdEqB2YXzWM=;
        b=Haf7gd/AiDity/gaULKQUKwSxgxyc/3EeuBuaAQgILjMkpk93UeGEp/Z9Enouq7X7i
         JznYjqdR/aurqH8wVQB/t+JiNlFxzFP8/sy3cjuBG0w3heWWBOP3wHXTpT+Ehrtc6YET
         VZf7ev8+uOtUW6HbToqlwUyYjIyLZqS0T8pdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BcYaImboXAz3ROV6Gy/kfOP/At07dIJ8OmjH5D9X9zPaD5piGp/aeFV5cJ/XIoVN1K
         bFtkc7h3+2LZkHw3ILw338K/WyF+v0DI/szMk2eW4Ajh0IX2OdSbhHGMWYwkWpjGpDpn
         X//2n8AJU5q+/bCeG1OjTL92U4jFIVN72IW/Q=
Received: by 10.115.101.1 with SMTP id d1mr14551888wam.40.1260261922398;
        Tue, 08 Dec 2009 00:45:22 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm5816988pzk.6.2009.12.08.00.45.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 00:45:21 -0800 (PST)
In-Reply-To: <20091208075616.4475.46720.chriscool@tuxfamily.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134844>

On Tue, 2009-12-08 at 08:56 +0100, Christian Couder wrote:
> +static int parse_and_init_tree_desc(const unsigned char *sha1,
> +					     struct tree_desc *desc)
> +{
> +	struct tree *tree = parse_tree_indirect(sha1);
> +	if (!tree)
> +		return 1;
> +	init_tree_desc(desc, tree->buffer, tree->size);
> +	return 0;
> +}
> +
>  

Is there a reason why you use this function instead of
fill_tree_descriptor()?
