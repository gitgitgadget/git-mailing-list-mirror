From: Brodie Rao <brodie@sf.io>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Thu, 8 Mar 2012 16:06:05 -0800
Message-ID: <CAJjwD-2=pEfk2WQ2=cKy8eUSwbx8y86jEo_kyiQWsxVTqVFQEg@mail.gmail.com>
References: <1331165362-78065-1-git-send-email-brodie@sf.io>
	<20120308055520.GB7643@sigill.intra.peff.net>
	<7vpqcnfvhs.fsf@alter.siamese.dyndns.org>
	<20120308071559.GF7643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 01:06:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5nM4-0003QI-T7
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 01:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab2CIAGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 19:06:08 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54146 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab2CIAGG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 19:06:06 -0500
Received: by pbcun15 with SMTP id un15so1994458pbc.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 16:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitheap.org; s=google;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=0eJa9L58+cF4XJSUOwvC7OwJZ2+7QpQlGIbD5yvwWHs=;
        b=gtZC0qsX/6Xcm5geoKcwP+wTS0/nEVhgaBW9E1YuKVy/oi5AsvRTApo7y5GXfyGoRM
         vT7UGhQkfkw44eNdW4K8KQrDe03uvkQW3OOT/gFyCQlCAcPopuTqBe8PuMQuwWzvPT7K
         nKQw6m8pJDJn7f5bsjUvmQdqBqvo7nEsTjk/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=0eJa9L58+cF4XJSUOwvC7OwJZ2+7QpQlGIbD5yvwWHs=;
        b=DN2mzx9V7DxQaZff+1WdizbN/aQDwTgwCwS5nATHjigni3jweGaAnDVG61/VbLCrox
         +avCFCD8MUAVwo3ZjnEVTsMu2ogF0rKv5YoTgPuX8N21o/CIy+vBEG2Dp//QJy5J37Uy
         lF/cTdv1ik4MgA0B89SWBiBtajZgg4uE4XlzfbwZq4Fw3YnQXcRGkK0HeR9AgdoChX+g
         s5DCLzJANx84VcZj+/N6z1z3gVtLsnNgyDCoCOWUaOM8np8nPysMA23xZbph5kV9ff+S
         65gxuCmnPURrv8DA/y17T5QWqtGEX8vAYBpxeYmEcb6HiMYNPPEfEylCaawCNDja9+se
         Pamg==
Received: by 10.68.237.201 with SMTP id ve9mr1222552pbc.45.1331251565323; Thu,
 08 Mar 2012 16:06:05 -0800 (PST)
Received: by 10.142.179.13 with HTTP; Thu, 8 Mar 2012 16:06:05 -0800 (PST)
X-Originating-IP: [70.35.42.138]
In-Reply-To: <20120308071559.GF7643@sigill.intra.peff.net>
X-Google-Sender-Auth: h71CJxsENIsGG5jxpuzARLv043E
X-Gm-Message-State: ALoCoQk5zIzy9/uRmJsM0KdD7IiaHqo7YOF5i4jJ0PK2FsBI+4iuHMjJs3fd+Yr7t9VLWVPzcfNJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192665>

2012/3/7 Jeff King <peff@peff.net>:
> On Wed, Mar 07, 2012 at 10:38:07PM -0800, Junio C Hamano wrote:
>
>> > ... However, prefix_pathspec does a lot of magic parsing;
>> > it's unclear to me whether this is all in support of properly
>> > adding the prefix, or if its side effects are important.
>>
>> These "magic" are for things like :(root)/path that will explicitly
>> refuse the prefix when run from a subdirectory.
>
> Yeah, that was my impression. In that case, I would think we could get
> rid of the get_pathspec call entirely, as it is purely about fixing-up
> prefixes, and we know that we have none.

Let me see if I've got this right: We're currently passing in ""/NULL
to get_pathspec() because we handle the prefix beforehand in
parse_treeish_args(). Once we get the tree object, every path is
relative to it, so we don't need to continue using a prefix.

Wouldn't it be better to continue using get_pathspec(), passing it the
real prefix, and looking up tree entries relative to the top-level
tree? The way it works now, you get weird behavior like this:

  $ cd xdiff
  $ git archive -v --format=tar HEAD ../t/t5000-tar-tree.sh > /dev/null
  fatal: '../t/t5000-tar-tree.sh' is outside repository
  $ git archive -v --format=tar HEAD .. > /dev/null
  fatal: '..' is outside repository
