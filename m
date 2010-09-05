From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add test-string-list.c
Date: Sun, 5 Sep 2010 00:02:58 -0500
Message-ID: <20100905050254.GA6134@burratino>
References: <4f798daaf4631e00927b455b77919d5bb8fade03.1283653854.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 07:05:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os7PY-0003Ob-SP
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 07:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791Ab0IEFE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 01:04:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50540 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab0IEFEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 01:04:55 -0400
Received: by iwn5 with SMTP id 5so3006735iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Vp6zxt/U5z/SpQfYK2VU0yrgrl+LYbPpfugRdiDbIyY=;
        b=qYPUcizWV+ZYygXHkXuCS4+NHoaHpwUOiHArkoPiIyiYGKwtxVCqx/ntZYvYc93RnX
         sHgwcMLAAKVA9sYMWsKeA/fuk1ylite2ti2rlg4NsIBCdVSfhcXa01EgbRRBQ1zSqlY1
         9ECr1mAAXmbsN45fRY6wLwVVTT1o9Bnma0TPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fLHBHdGQMDE9jhq5CX94Urxcn0hbWqUrgc5A6M8rNHESeE7PWQ8mcRk0DYZ0bwzcs3
         xCdZ0KHdZdA0NhP+MYR3VoIw+pIauaOeRjA14ZmVDr0f8DU9DOVthn0l68uCYvOLq2Ec
         /tXxgC1QhmQt9H/l5tg0HnZElk9//INWp52m8=
Received: by 10.231.172.83 with SMTP id k19mr3813356ibz.114.1283663094772;
        Sat, 04 Sep 2010 22:04:54 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i6sm1320975iba.14.2010.09.04.22.04.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 22:04:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4f798daaf4631e00927b455b77919d5bb8fade03.1283653854.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155423>

Hi Thiago,

Thiago Farina wrote:

> Add a simple test that demonstrates how to create and manipulate
> a list of strings using the string-list.h API.

Quick thoughts:

> --- /dev/null
> +++ b/test-string-list.c
> @@ -0,0 +1,29 @@
> +#include <stdio.h>

Git programs tend to start with 

 #include "cache.h"

or

 #include "git-compat-util.h"

to get all the portability niceties.

> +	print_string_list(&list, "");
> +
> +        int has_foo = string_list_has_string(&list, "foo");

Whitespace, declaration after statement... (see
Documentation/CodingGuidelines).

> +	if (has_foo != 1)
> +		error("List doesn't have foo.");

This does not exit with nonzero status when it fails.  You probably
wanted

	if (bad things)
		return error("problems!");

> +	string_list_clear(&list, 0);
> +	if (list.nr > 0)
> +		error("List is not clear.");

To make sure this example remains valid, wouldn't you want to include
a caller in the t/ directory so it can be automatically run?  (See
t/README.)

Thoughts separate from the code:

 * it is probably worth mentioning Documentation/technical/api-string-list.txt
   for people who do not know about it.

 * for this to be useful as a test I think one has to sort of believe
   that it can break.  That is, a test of something this basic (which
   is already demonstrated and exercised by code throughout git, after
   all) would tend to be especially devious.

 * api-string-list.txt does not mention the STRING_LIST_INIT macros
   you introduced.  Maybe that would be worth improving.

Regards,
Jonathan
