From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Exact format of tree objets
Date: Tue, 11 Jun 2013 21:26:49 +0300
Message-ID: <20130611182649.GA24704@LK-Perkele-VII>
References: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:34:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTOQ-000253-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab3FKSeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:34:01 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:57701 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab3FKSeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:34:00 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2013 14:34:00 EDT
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02.mail.saunalahti.fi (Postfix) with SMTP id 071CB81804;
	Tue, 11 Jun 2013 21:26:50 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02B8E03879; Tue, 11 Jun 2013 21:26:50 +0300
Received: from LK-Perkele-VII (a88-112-44-140.elisa-laajakaista.fi [88.112.44.140])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id EA6E81887DD;
	Tue, 11 Jun 2013 21:26:49 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227489>

On Tue, Jun 11, 2013 at 01:25:14PM -0300, Chico Sokol wrote:
> Is there any official documentation of tree objets format? Are tree
> objects encoded specially in some way? How can I parse the inflated
> contents of a tree object?

Tree object consists of entries, each concatenation of:
- Octal mode (using ASCII digits 0-7).
- Single SPACE (0x20)
- Filename
- Single NUL (0x00)
- 20-byte binary SHA-1 of referenced object.

At least following octal modes are known:
40000: Directory (tree).
100644: Regular file (blob).
100755: Executable file (blob).
120000: Symbolic link (blob).
160000: Submodule (commit).

The entries are always sorted in (bytewise) lexicographical order,
except directories sort like there was impiled '/' at the end.

So e.g.:
! < 0 < 9 < a < a- < a- (directory) < a (directory) < a0 < ab < b < z.


The idea of sorting directories specially is that if one recurses
upon hitting a directory and uses '/' as path separator, then the
full filenames are in bytewise lexicographical order.

-Ilari
