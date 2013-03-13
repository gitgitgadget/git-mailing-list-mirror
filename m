From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Wed, 13 Mar 2013 08:11:00 +0700
Message-ID: <CACsJy8DLDZqacrEZ4T0VkSr00wW2z6q-MsX0NKjcPhLdtgFV5Q@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com> <1362896070-17456-4-git-send-email-pclouds@gmail.com>
 <7vy5dvd7yq.fsf@alter.siamese.dyndns.org> <CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
 <7v7glc72rn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 02:12:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFaEZ-0001zm-1G
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 02:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764Ab3CMBLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 21:11:32 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:45757 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3CMBLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 21:11:31 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so527291oag.20
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 18:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+yqmg91DIGFdJ2PQpR8L2+5SFV5LdDwlM36/Jj5Ffe8=;
        b=FtGuX7/W0jL49p984LJPOGfuC/pdqUSNL6n2kYuAYNCFjQvAY2z0bAJaFyiVUOyqb7
         yo2qpSZ9cv7DLn4yNFUm4OQqwRgw3+86ajw9tQsAeJNmlIZd4yNNN0gE1ABpDKeVAZZs
         TSxOyPKgDVIkzEHZScvGU82A3tQk0nymvFiuq13ZuBQwSYG+apQYWKPgsKlSRLtO9VqI
         HLIF3SoM5WlHSw1h8VT5R5jHs5ucsvCGB0FYxQ1gmVvMn8IwmOPe2TyyacbTJYHTp3NH
         TfwTkn3n6v97qYaQKICGqPIAVC1hRbndY2oWKE6toz1TuXQyt+zhge//brYmsaFYzh8J
         lRYw==
X-Received: by 10.60.6.199 with SMTP id d7mr13682743oea.137.1363137090879;
 Tue, 12 Mar 2013 18:11:30 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 12 Mar 2013 18:11:00 -0700 (PDT)
In-Reply-To: <7v7glc72rn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218019>

On Wed, Mar 13, 2013 at 3:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> strncmp is provided length information which could be taken advantage
>>> by the underlying implementation.
>
> After all, strcmp() could also be optimized to fetch word-at-a-time
> while being careful about not overstepping the page boundary.

It boils down to giving more information to the underlying
implementation with hope that it can be useful for something. Although
at this point I think strncmp vs strcmp vs memcmp may be not worth
doing (we keep explicit length comparison to reduce *cmp calls
though). The gain is relatively small and will become even smaller
after we avoid running exclude on tracked files (which eliminates like
2/3 of the processed entries).
-- 
Duy
