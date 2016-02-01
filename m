From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 6/6] worktree add: switch to worktree version 1
Date: Mon, 1 Feb 2016 07:33:33 +0200
Message-ID: <20160201053333.GE4978@wheezy.local>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	max@max630.net, git@drmicha.warpmail.net, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 06:40:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ7EG-0000JS-Po
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 06:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbcBAFkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2016 00:40:45 -0500
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:47027
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750791AbcBAFko (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 00:40:44 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2016 00:40:44 EST
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id CtZX1s0035B68XE01tZZsj; Sun, 31 Jan 2016 22:33:36 -0700
Content-Disposition: inline
In-Reply-To: <1453808685-21235-7-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285187>

On Tue, Jan 26, 2016 at 06:44:45PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> +		for (key_p =3D per_wortree_keys; *key_p; key_p++) {
> +			const char *key =3D *key_p;
> +			char *value =3D get_key(sb.buf, key);
> +
> +			if (value) {
> +				if (git_config_set(key, value))
> +					die(_("failed to keep %s in main worktree's config file"), key)=
;
> +				if (git_config_set_in_file(sb.buf, key, NULL))
> +					die(_("failed to delete %s in shared config file"), key);
> +				free(value);
> +			}
> +		}

1. For submodules (which must be left per-worktree) this
approach is not going to work, because you don't know all
variables in advance. You could scan the config file and
match those actual keys which are there with patterns.

2. This migrates variables to the default (or current?)
worktree, what about others existing?

--=20
Max
