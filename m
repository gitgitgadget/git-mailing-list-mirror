From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/8] sha1_file: introduce has_object_file helper.
Date: Wed, 10 Jun 2015 16:59:58 +0700
Message-ID: <CACsJy8DHJ415euwo3gMTtuQx+5RopzBg+mssZ8TVstGJcdWSqg@mail.gmail.com>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net> <1433867316-663554-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 12:00:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2coE-0005dt-TM
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 12:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbbFJKAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 06:00:31 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37914 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbbFJKA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 06:00:29 -0400
Received: by igblz2 with SMTP id lz2so29777067igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JXIhXsoV3qIh+EHMmDzs3KTmV6vKW1uSsVbhDxoO3MM=;
        b=Ya1ImE6bLRnjBOlan/o44RHPCijuSZ4XBAiPPtpBM4NN40cmqaWHfDuFLO51XeRmXu
         6jaURtmxjkUzffCRBNCQxbTTDJuLb1wDXrQMD4AiBIOlKP7BVNKOS3YqA8GiWK4qMd/O
         JwYMzTBewPYoBT7aSOKrSCcvlD3vPaGyuFQkdNT7GXLGL82w5o0Mzz3K9X5DAk34z+EA
         F8jCuS36/4+lfcNuAdoaLq9iPSR0nkLJS8lck60VK7LWzznMIfwfTNzvfLtSy65RE7Es
         J4zRT/msKfvLylnKk5Q6sDnyxchz63ErA1NxYdVLyd5JmnwQSz0xkNl4vioMKjabXiQt
         i8LA==
X-Received: by 10.50.7.68 with SMTP id h4mr4727215iga.40.1433930429113; Wed,
 10 Jun 2015 03:00:29 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Wed, 10 Jun 2015 02:59:58 -0700 (PDT)
In-Reply-To: <1433867316-663554-3-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271280>

On Tue, Jun 9, 2015 at 11:28 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/sha1_file.c b/sha1_file.c
> index 7e38148..09f7f03 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3173,6 +3173,11 @@ int has_sha1_file(const unsigned char *sha1)
>         return find_pack_entry(sha1, &e);
>  }
>
> +int has_object_file(const struct object_id *oid)
> +{
> +       return has_sha1_file(oid->hash);
> +}
> +

This version could be "static inline" and placed in cache.h. Though it
may be premature optimization. On top of my head I can't recall any
place where has_sha1_file() is used so many times for this extra call
to become significant overhead.
-- 
Duy
