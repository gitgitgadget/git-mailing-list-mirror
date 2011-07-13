From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 10:18:28 +0200
Message-ID: <CAKPyHN1FgK6NXqZFZ=OvMgouhfxnGF0aXU+--y-P1u9BcK9Z4A@mail.gmail.com>
References: <20110713064709.GA18499@sigill.intra.peff.net>
	<20110713070405.GB18566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 10:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgueS-0006rj-Se
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050Ab1GMISb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 04:18:31 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42774 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965047Ab1GMIS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 04:18:29 -0400
Received: by vws1 with SMTP id 1so4035098vws.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JyNiFTgyXE6sP8qILCcqYNGg2r19OO18/i+LmNZ/R5E=;
        b=M6C64n9nLR2xbYewSVy18rhoWGhp098ijt1Go1T/J4wLMC4t54o9e8ZItTZ8XvUQro
         m0u7/iY59McavfX/jvhaF2U1lrvPdM9ISjB+4u7nTjzi7bY2M8Z5pmWNE97Lcw3/OvDS
         biz+U78GpbK0FxbEOH7N0leK09Svb9N8Uxmjk=
Received: by 10.52.111.200 with SMTP id ik8mr569827vdb.128.1310545108659; Wed,
 13 Jul 2011 01:18:28 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Wed, 13 Jul 2011 01:18:28 -0700 (PDT)
In-Reply-To: <20110713070405.GB18566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177011>

On Wed, Jul 13, 2011 at 09:04, Jeff King <peff@peff.net> wrote:
> diff --git a/metadata-cache.c b/metadata-cache.c
> new file mode 100644
> index 0000000..e2e5ff8
> --- /dev/null
> +++ b/metadata-cache.c
> @@ -0,0 +1,337 @@
> +#include "cache.h"
> +#include "metadata-cache.h"
> +#include "sha1-lookup.h"
> +#include "object.h"
> +
> +static struct metadata_cache **autowrite;
> +static int autowrite_nr;
> +static int autowrite_alloc;
> +
> +static int installed_atexit_autowriter;
> +
> +static int record_size(const struct metadata_cache *c)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /* a record is a 20-byte sha1 plus the width o=
f the value */
> + =C2=A0 =C2=A0 =C2=A0 return c->mem.width + 20;

You are circumventing your own API. Why do you don't use the
decoration_width() accessor here? I don't see any check that
METADATA_CACHE_INIT("frotz", 0, NULL) is invalid neither in the
documentation nor in the code.

> +}
> +

Bert
