From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/18] notes.h/c: Propagate combine_notes_fn return value
 to add_note() and beyond
Date: Tue, 5 Oct 2010 10:38:38 -0500
Message-ID: <20101005153838.GG12797@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:42:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39ed-0005V8-U6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab0JEPl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 11:41:58 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48660 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab0JEPl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 11:41:57 -0400
Received: by pxi10 with SMTP id 10so1673838pxi.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=79qqHmT0InzO+PlU7x/Z1JrxAtRJSbIKTFGBVUDzhjE=;
        b=OKxmAs9aU6uvBfnBByI/cgW5N3i41598gdAGSUcqZWYtfs13UwMaS6mqwRNQ3kdEty
         xTGiBmewobSn2tOeZH9lQilb9nvM84Ty7tLmce9TwLi49epSklJ4H+hjF1ZJOjNM/qtd
         14GuzO1WQiLlJzBuriWnKoi5GAsks0CNV4uwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FTIsuE2ztblQ673KzEiTMigawP+ZVdCljD+YYDGEKtP2zlFgWLbatM0ZF9Eu1l3BpR
         X0ZTgcKgdzCxr1sZMkrboqwTQmtI+dgt/HK3XPEZGr0qjVqmpbFNEg4AvdgwklFTnxTy
         wMCk3TN838H+cBj/A3Bo12RXNsryXGEZrRbb4=
Received: by 10.142.121.7 with SMTP id t7mr10466566wfc.88.1286293316985;
        Tue, 05 Oct 2010 08:41:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id e31sm5049138vbe.9.2010.10.05.08.41.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 08:41:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285719811-10871-5-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158208>

Johan Herland wrote:

> The combine_notes_fn functions uses a non-zero return value to indicate
> failure. However, this return value was converted to a call to die()
> in note_tree_insert().

For what it's worth, I still like it.

> Instead, propagate this return value out to add_note(), and return it
> from there

It's always odd deciding what to do in the code paths that "can't
happen".  Ideally one would want static analyzers to check that, while
at the same time subjecting the user to some nice graceful fallback
behavior when it happens anyway.

	fatal: confused: combine_notes_overwrite failed

In this case I'm not sure what the message in die() should be, but
it seems sane to die with some message.  Maybe this should be
mentioned in the commit message, though?
