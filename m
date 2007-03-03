From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH 5/7] Try to do things in the right order
Date: Sat, 03 Mar 2007 11:32:54 +0100
Message-ID: <87ps7qty5l.fsf@wine.dyndns.org>
References: <15303.1172917192@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 11:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNRXx-0000fK-Dy
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXCCKc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXCCKc6
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:32:58 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:32875 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbXCCKc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:32:57 -0500
Received: from adsl-89-217-4-70.adslplus.ch ([89.217.4.70] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HNRXs-0002ul-Dq; Sat, 03 Mar 2007 04:32:56 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 787D14F691; Sat,  3 Mar 2007 11:32:54 +0100 (CET)
In-Reply-To: <15303.1172917192@localhost> (Xavier Maillard's message of "Sat\, 03 Mar 2007 11\:19\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41286>

Xavier Maillard <zedek@gnu.org> writes:

> @@ -35,8 +36,14 @@
>    (require 'vc)
>    (require 'cl))
>  
> -;; Add it automatically
> -(add-to-list 'vc-handled-backends 'GIT)
> +;; HACK: clear up the cache to force vc-call to check again and
> +;; discover new functions when we reload this file.
> +(put 'GIT 'vc-functions nil)
> +
> +;; Add it automatically when loading vc
> +;; FIXME: should be directly put into vc.el
> +(eval-after-load "vc"
> +  '(add-to-list 'vc-handled-backends 'GIT))

That's ugly. Simply recommending that users set vc-handled-backends in
their .emacs is easier and cleaner, I still don't see why you want to
change it.

-- 
Alexandre Julliard
julliard@winehq.org
