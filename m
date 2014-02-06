From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 10/17] trailer: if no input file is passed, read
 from stdin
Date: Thu, 06 Feb 2014 21:16:39 +0100 (CET)
Message-ID: <20140206.211639.74249240425700292.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.57934.chriscool@tuxfamily.org>
	<CAPig+cTVN+MqjhouCsE2gi4GWd14dLH6=5QrbEfTTgz5jLxtKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Thu Feb 06 21:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVNS-00080g-LY
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbaBFUQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:16:43 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:63541 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBFUQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:16:42 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 96F2C60;
	Thu,  6 Feb 2014 21:16:40 +0100 (CET)
In-Reply-To: <CAPig+cTVN+MqjhouCsE2gi4GWd14dLH6=5QrbEfTTgz5jLxtKA@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241724>

From: Eric Sunshine <sunshine@sunshineco.com>
>
> On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> It is simpler and more natural if the "git interpret-trailers"
>> is made a filter as its output already goes to sdtout.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/trailer.c b/trailer.c
>> index 8681aed..73a65e0 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -464,8 +464,13 @@ static struct strbuf **read_input_file(const char *infile)
>>  {
>>         struct strbuf sb = STRBUF_INIT;
>>
>> -       if (strbuf_read_file(&sb, infile, 0) < 0)
>> -               die_errno(_("could not read input file '%s'"), infile);
>> +       if (infile) {
>> +               if (strbuf_read_file(&sb, infile, 0) < 0)
>> +                       die_errno(_("could not read input file '%s'"), infile);
>> +       } else {
>> +               if (strbuf_read(&sb, fileno(stdin), 0) < 0)
> 
> strbuf_fread(), perhaps?

I chose strbuf_read() because it can be passed 0 as a size hint, while
strbuf_fread() must be passed an exact size.

(As we might read from stdin, we might not be able to know the exact
size before we start reading.)

Thanks,
Christian.
