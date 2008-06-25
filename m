From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 12/13] Build in merge
Date: Wed, 25 Jun 2008 18:22:45 +0200
Message-ID: <486270D5.5050204@free.fr>
References: <cover.1214066798.git.vmiklos@frugalware.org> <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org> <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org> <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org> <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXmY-000799-TD
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759487AbYFYQWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 12:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759383AbYFYQWi
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:22:38 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:43702 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759265AbYFYQWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:22:37 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D22D612B6C3;
	Wed, 25 Jun 2008 18:22:35 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 392EC12B6BC;
	Wed, 25 Jun 2008 18:22:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86300>

Hi,

I did not read your patches yet but I noticed the two following bugs wh=
ile testing
current pu.

Miklos Vajna a =E9crit :
>
> +static void finish(const unsigned char *new_head, const char *msg)
> +{

[...]

> +	if (new_head && show_diffstat) {
> +		diff_setup(&opts);
> +		opts.output_format |=3D
> +			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> +		opts.detect_rename =3D DIFF_DETECT_RENAME;

You probably want to add DIFF_OPT_SET(&opts, COLOR_DIFF) to have a nice=
 colored diff
like the original script.

> +		diff_tree_sha1(head, new_head, "", &opts);
> +		diffcore_std(&opts);
> +		diff_flush(&opts);
> +	}

[...]

> +int cmd_merge(int argc, const char **argv, const char *prefix)
> +{

[...]

> +	} else if (allow_fast_forward && !remoteheads->next &&
> +		!hashcmp(common->item->object.sha1, head)) {
> +		/* Again the most common case of merging one remote. */
> +		struct strbuf msg;
> +		struct object *o;
> +
> +		printf("Updating %s..%s\n",
> +			find_unique_abbrev(head, DEFAULT_ABBREV),
> +			find_unique_abbrev(remoteheads->item->object.sha1,
> +			DEFAULT_ABBREV));

Here, the second call to find_unique_abbrev() will overwrite the previo=
us returned
value because this function return a pointer to a static buffer.

Olivier.
