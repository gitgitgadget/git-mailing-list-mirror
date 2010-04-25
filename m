From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH] daemon.c: avoid accessing ss_family member of struct
 sockaddr_storage
Date: Sun, 25 Apr 2010 03:37:03 -0500 (CDT)
Message-ID: <20100316065127.GA26370@thor.il.thewrittenword.com>
References: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
 <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil>
 <20100315212915.GB25342@coredump.intra.peff.net>
 <s0MQZSOEsdBJUhITxC3jwfFJk5PnIEo0WR5z_GEnSOw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	kusmabite@gmail.com, martin@martin.st,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:37:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xKy-0006Dx-M7
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab0DYIhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:37:05 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:58247 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab0DYIhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:37:04 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id A809D5CED
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:58:05 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com A809D5CED
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 4FF019A4
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:37:03 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 0F12457C; Sun, 25 Apr 2010 03:37:03 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <s0MQZSOEsdBJUhITxC3jwfFJk5PnIEo0WR5z_GEnSOw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145724>

The git@mlists... address is the one subscribed to this list, to make
it easy for us to filter list messages into shared folders.  Because
we manage so many packages, one or other of us will drop in and out of
contact on the relevant lists depending what package we happen to be
working on.

Anyway, you can always put a post directly in my INBOX by Cc:ing
gary@thewrittenword.com and/or gary@gnu.org if you'd like to be sure
that I will read something. :)

On Mon, Mar 15, 2010 at 04:42:57PM -0500, Brandon Casey wrote:
> I expect that the layout of the sockaddr_* family of structures will
> follow the layout of struct sockaddr, otherwise they wouldn't be
> compatible.
> 
> In other words, I think that if struct sockaddr looks like this:
> 
>   struct sockaddr {
>         uchar_t         sa_len;         /* total length */
>         sa_family_t     sa_family;      /* address family */
>         char            sa_data[14];    /* actually longer; address value */
>   };
> 
> then somewhere else, struct sockaddr_in looks like this:
> 
>   struct sockaddr_in {
>         uchar_t         sin_len;
>         sin_family_t    sin_family;
>         sin_port;
>         sin_addr;
>         ...
>   };

> On 03/15/2010 04:29 PM, Jeff King wrote:
> > Or am I wrong in assuming that, and on AIX sockaddr_in actually has
> > sa_len at the front, so casting to sockaddr does the right thing (and my
> > recommendation above would actually be broken)? The AIX boxen I have
> > access to are all down at the moment.
> 
> Maybe Gary can check for us... Gary, what does the declaration for
> struct sockaddr_in look like in your AIX header file?

/usr/include/netinet/in.h excerpt:

/*
 * Socket address, internet style.
 */
struct sockaddr_in {
        uchar_t        sin_len;
        sa_family_t    sin_family;
        in_port_t      sin_port;
        struct in_addr sin_addr;
        uchar_t        sin_zero[8];
};

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
