From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/15] submodule--helper: die on config error when
 cloning module
Date: Tue, 2 Feb 2016 13:45:50 -0500
Message-ID: <CAPig+cSLoXGHFXm96dpfjmkZkpXOFezEFZek-Jry85XkCwOsWA@mail.gmail.com>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
	<1454413916-31984-7-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:46:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQfxf-0008I9-S5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 19:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933708AbcBBSpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 13:45:54 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34397 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933744AbcBBSpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 13:45:51 -0500
Received: by mail-vk0-f68.google.com with SMTP id e6so6145672vkh.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 10:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pxhl+xYbn5PMHcONKUYzbk6V0K/CT8mFVeY7Qb2txxo=;
        b=cD3EwHaj3ZBfJpBEAc4k496EWVt3vRBbON/DtDtYPsRmLD6wAjq7+m2wom+yYxWHu8
         Gvj116NsGl6bhhKXG4mFqEZ2WubHCt5KFVqpdqAep5UAgKHo6MF4Xl+QEBGO9oJSvV2w
         a01/V3bVcYbcopnnaUfG9C9A0lpnzClsztsdJYv4oc8ERLGebokFKOfp4ewUQFiJlHbq
         FLbpv4Tn2ROyQBHGhAcy9rIgLkOlKrZXOILv2wAOhu2r3J54PQUaMrCWf8YL32b3irhu
         ZhxvjG/Nkuz6eu/XguQZq96IvMzxZfLzdErdXRgi7tYYrX4yXsHVl7fU+PQB9Iaoyqw0
         I3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pxhl+xYbn5PMHcONKUYzbk6V0K/CT8mFVeY7Qb2txxo=;
        b=PajCGvBS7OWJuo0HP5g/DeNZsSDDqTW1jJCKRLyCh9uyzlD3nLNrun/+uJ26WqUMMg
         22S+vy7iBBoJYCeXJ6wcstWDZRMJA3f5cAlqxX4fRx6Qz9QL451zEw9UShQ4rBz635js
         ByoyLU2xJ+mXV/6Sa9NXoX6N1hgS8DtVaGIvWs2Q5+TONSwIVuO+DHPLWioQcM7p8KP3
         Za7mSN3iwrPS1nWxT2u6eC7RGh17vrGzaqLIxOpEgmSCCy8QaqtEg71yudo7+c38tqud
         u3z2g3hi5lSnLCT12nIzJppUaufq+GaUubzPXqJ8cEOqTzNHMj851uf2BSnm0BJ/i+MI
         GjLA==
X-Gm-Message-State: AG10YOScoj901hZvybRNo5bF7HEhQ+1YhXz3Zxpr4PMXs0P5Jh2aanCq79fswkVZuhwaoQfIXRqgREBbP1ddAw==
X-Received: by 10.31.146.71 with SMTP id u68mr8101417vkd.19.1454438750631;
 Tue, 02 Feb 2016 10:45:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 2 Feb 2016 10:45:50 -0800 (PST)
In-Reply-To: <1454413916-31984-7-git-send-email-ps@pks.im>
X-Google-Sender-Auth: fmoF91pH-gqmOruvs6MBCIWIuV8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285295>

On Tue, Feb 2, 2016 at 6:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
> When setting the 'core.worktree' option for a newly cloned
> submodule we ignore the return value of `git_config_set_in_file`.
> As this leaves the submodule in an inconsistent state, we instaed
> we want to inform the user that something has gone wrong by

s/instaed/instead/

Also, there are too many "we"s, so dropping one would be a good idea:
either "we instead" or "instead we".

> printing an error and aborting the program.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
