From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a file
Date: Fri, 8 Feb 2008 15:15:40 -0500
Message-ID: <118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com>
References: <20080208174654.2e9e679c@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZdy-00052x-U7
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935706AbYBHUPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935699AbYBHUPp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:15:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:40842 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935469AbYBHUPo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:15:44 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2983503fga.17
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=H4HhLt5G44/hKXSKjmdi5ZFnOU/bnGDK2QvqcG81Tdg=;
        b=Npg3ryucrDrHPsoHKL5gvRCY7xuoTUSaceR0rIWoTg5uYllL9KgtvHJkjiHgoR1SWfbqqjFy8Pq+ITLTsUY8ko8dTQoenofNoGPtIsA9z7JZWdgnBKJ8bqx/6+QK57lxx4bSqgz/0EZFfB+LhatZh+IvqUWOs330iVf8rT+zdUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mAb2J5hSaZcOfYGiqYhAH6VMHhyoXLvc76BN42c9FxQQH8Mbf9tlv9OiEHZXBF9drQQqEQASx98UzdsWnQIwI6U2wP12bX8c9F0r993g9WDiNvwQ0h7GGP9ASjB7wBnIKbL6hwJxi8GZAXTxmYH7bVaqFgUhIld7yXLmyzbV51I=
Received: by 10.86.99.9 with SMTP id w9mr12072848fgb.58.1202501740178;
        Fri, 08 Feb 2008 12:15:40 -0800 (PST)
Received: by 10.86.1.11 with HTTP; Fri, 8 Feb 2008 12:15:40 -0800 (PST)
In-Reply-To: <20080208174654.2e9e679c@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73131>

> +/* Helper function to ensure that we are opening a file and not a directory */
> +static FILE *open_file(char *full_path)
> +{
> +       struct stat st_buf;
> +       if (stat(full_path, &st_buf) || !S_ISREG(st_buf.st_mode))
> +               return NULL;
> +       return (fopen(full_path, "r"));
> +}

That looks wrong.  stat+fopen has a pointless race condition that
open+fstat+fdopen would not have.

Morten
