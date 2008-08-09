From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sat, 9 Aug 2008 14:49:20 -0700
Message-ID: <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com>
References: <20080809210733.GA6637@oh.minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jamey Sharp" <jamey@minilop.net>,
	"Josh Triplett" <josh@freedesktop.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 23:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRwKO-0000T8-I2
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYHIVtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 17:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYHIVtV
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 17:49:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:30667 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbYHIVtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 17:49:20 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1617661rvb.1
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2ejwOfLrLPo1cj/SDVP+RVyaEjnAc6l/sAfB2zIEvBo=;
        b=qNUUlYQkABBGSsXl3aSTIUJH8OdU5Z7/WSCu2vLSd29loAxJsIGtj1SS3MWkiAwlI4
         L8oTu5fG7aDR0O1CLe/AK+a2V1aOazBpKFjplof5/7UPkTsFjzCXX4RpZNzStzGr5fIZ
         zPwEj+fUSnEJI9XhDrs4TTLdduqR5Q7cD+Rmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xA1BR8z87LJKZpRrH/W/8mcHesBskBq4vWdWx8qge2MX+rkpwKcT0n0YvqH+Pxqvfi
         Nb251sQbXLIlZfAo8vJ3X7YrjqJ5aRC5KtZVXKNdM5w4Zg9iiP1EsiC6nmuzdM7t7/QT
         t0m6+kXdH/eoE93q0G/zsmDB0TuLvQOWkU9CI=
Received: by 10.114.133.1 with SMTP id g1mr2671518wad.123.1218318560236;
        Sat, 09 Aug 2008 14:49:20 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Sat, 9 Aug 2008 14:49:20 -0700 (PDT)
In-Reply-To: <20080809210733.GA6637@oh.minilop.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91785>

> We began trying to implement this proposal, but we found this enum
> definition in cache.h, which made us think there's only room for one
> more kind of object:
>
>        enum object_type {
>                OBJ_BAD = -1,
>                OBJ_NONE = 0,
>                OBJ_COMMIT = 1,
>                OBJ_TREE = 2,
>                OBJ_BLOB = 3,
>                OBJ_TAG = 4,
>                /* 5 for future expansion */
>                OBJ_OFS_DELTA = 6,
>                OBJ_REF_DELTA = 7,
>                OBJ_ANY,
>                OBJ_MAX,
>        };
>
> Do these object_type values appear in any on-disk structure, or does any
> other reason exist why this set of values cannot change? Can we add
> additional object types for inodes and props? If not, what would you
> recommend instead?

If I'm not mistaken, these are the values used to identify data in the
header sections of packfile objects.  The first four bits are used to
identify the object type, where the first bit is static and the next
three are the object type of the data following the header.  Since the
type is encoded using those three bits, 0-7 is the valid range.  I
would assume that would be difficult to change, since all the
packfiles depend on that range.

Scott
