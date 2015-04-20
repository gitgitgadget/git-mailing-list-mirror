From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Mon, 20 Apr 2015 08:34:33 +0700
Message-ID: <CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
References: <55300D2C.9030903@web.de> <1429319946-19890-1-git-send-email-pclouds@gmail.com>
 <5533A567.7070301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 03:38:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk0eu-0000Wt-RX
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 03:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbDTBfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 21:35:05 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35419 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbDTBfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 21:35:04 -0400
Received: by iejt8 with SMTP id t8so106152771iej.2
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kzswARzK5bieaYaFeuKdiv/kAabD740zFw/bl8202ow=;
        b=kkQdK9ErraUfTy6JjLVoBvNlwLchNLlT5HJ6wGkdOQrk+VT7VO8nchcfGJhEE12hZ/
         Dgw0R9x2fyhGk7afgpWjYfplvMDnjaOLFaDB542qtCm7NctYrgT9m0ZmqVAVoxnuJlVM
         jRKmWdTbqZjs7Pu7yynTStYl4TnGmnPbTRp922GRa7im12/i4bH5+ToRYB7xuXim87ke
         O3U4f51BUGNC6IdDFWOBC+lDnKSYxuLHbXwWUDk5fUsa4YAewkRKpL7yM/FI6ZmNoxkb
         x3TwHyfnPOGuCpONr0KgKciB1HkwtICH6TyU3lNHOJVV7ohhHdafb2fFFqiSLedaQP+s
         uxCg==
X-Received: by 10.107.12.158 with SMTP id 30mr18159061iom.61.1429493703861;
 Sun, 19 Apr 2015 18:35:03 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Sun, 19 Apr 2015 18:34:33 -0700 (PDT)
In-Reply-To: <5533A567.7070301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267446>

On Sun, Apr 19, 2015 at 7:53 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> And me thinks it should error out. We already do that when trying
> to add a specific file from above the gitlink:
>
>    $ git add subrepo/a
>    fatal: Pathspec 'subrepo/a' is in submodule 'subrepo'
>
> And from below the gitlink:
>
>    $ cd subrepo
>    $ git add a
>    fatal: Pathspec 'a' is in submodule 'subrepo'
>
> I think we should do the same when using "git add ." below the
> gitlink.

But if you look at it another way, "cd subrepo; git add ." should be
the same as "git add subrepo" and the latter does not error out (I
think because it hits the "if (!is_directory())" in
is_submodule_modified()). If we make the former error out, I suspect
the latter will follow the same behavior. Just double checking if this
is what we want..
-- 
Duy
