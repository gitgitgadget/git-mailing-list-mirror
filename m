From: Chico Sokol <chico.sokol@gmail.com>
Subject: Re: Exact format of tree objets
Date: Tue, 18 Jun 2013 12:15:52 -0300
Message-ID: <CABx5MBTtvyZT+TUj6iibFngbMnGoDvFT2wXM6oDACtuJ46kR7Q@mail.gmail.com>
References: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
 <20130611182649.GA24704@LK-Perkele-VII>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:16:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoxdr-0008T8-5o
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab3FRPQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:16:14 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35168 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab3FRPQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:16:13 -0400
Received: by mail-vb0-f46.google.com with SMTP id 10so3001111vbe.33
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DOYN3K3lidikXvmr845X681D/IpHcPD2uwG6fdQqOK8=;
        b=oecaMC6iXFMW2Un2b3wwCnntiTZb3U0o5rLlxto0wpc6r5ABWWImBuv399Ewgy/7ft
         XPyVOSpKy0TzBK4crE5bRBXR7yWWjomEB9Tu68XINns59h9wnPQiILGAMK9S2yt/7PXH
         Ow9sTpzrAGzIZ217eMCIQmdiRRX6isRPJ8XvCQzTnII5kzqmBJG5h+tYS96qQyej9vXL
         5fNGvbBDgeJ5sZLz0zBHTgZQPpdmU4PZ+54/RHp417+Kw79rvf1Lq337GwuHE6RFV/xk
         5BJlJ+K0ysPqqgGQ4pE4O9haZP7clY+Vmh3QfU3/Gg+POJUMufF1RHhe4rUlG3U6pmKz
         kAGw==
X-Received: by 10.58.181.225 with SMTP id dz1mr5498573vec.95.1371568572149;
 Tue, 18 Jun 2013 08:16:12 -0700 (PDT)
Received: by 10.221.2.134 with HTTP; Tue, 18 Jun 2013 08:15:52 -0700 (PDT)
In-Reply-To: <20130611182649.GA24704@LK-Perkele-VII>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228250>

What is the encoding of the filename?


--
Chico Sokol


On Tue, Jun 11, 2013 at 3:26 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Tue, Jun 11, 2013 at 01:25:14PM -0300, Chico Sokol wrote:
>> Is there any official documentation of tree objets format? Are tree
>> objects encoded specially in some way? How can I parse the inflated
>> contents of a tree object?
>
> Tree object consists of entries, each concatenation of:
> - Octal mode (using ASCII digits 0-7).
> - Single SPACE (0x20)
> - Filename
> - Single NUL (0x00)
> - 20-byte binary SHA-1 of referenced object.
>
> At least following octal modes are known:
> 40000: Directory (tree).
> 100644: Regular file (blob).
> 100755: Executable file (blob).
> 120000: Symbolic link (blob).
> 160000: Submodule (commit).
>
> The entries are always sorted in (bytewise) lexicographical order,
> except directories sort like there was impiled '/' at the end.
>
> So e.g.:
> ! < 0 < 9 < a < a- < a- (directory) < a (directory) < a0 < ab < b < z.
>
>
> The idea of sorting directories specially is that if one recurses
> upon hitting a directory and uses '/' as path separator, then the
> full filenames are in bytewise lexicographical order.
>
> -Ilari
