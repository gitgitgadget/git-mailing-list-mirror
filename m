From: Andreas Ericsson <ae@op5.se>
Subject: Re: [nit] diff func headers ignore context
Date: Wed, 14 Sep 2011 12:13:25 +0200
Message-ID: <4E707E45.5070102@op5.se>
References: <20110913215026.GA26743@sigill.intra.peff.net> <20110913215824.GG24490@sigill.intra.peff.net> <20110913220421.GA24549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 12:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3mTM-0005ep-Ih
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 12:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab1INKN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 06:13:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35979 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab1INKN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 06:13:28 -0400
Received: by bkbzt4 with SMTP id zt4so1390369bkb.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 03:13:27 -0700 (PDT)
Received: by 10.204.141.89 with SMTP id l25mr1463412bku.310.1315995206905;
        Wed, 14 Sep 2011 03:13:26 -0700 (PDT)
Received: from vix.int.op5.se (c83-248-99-226.bredband.comhem.se [83.248.99.226])
        by mx.google.com with ESMTPS id f15sm3370762bke.2.2011.09.14.03.13.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 03:13:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.20) Gecko/20110831 Fedora/3.1.12-2.fc14 Thunderbird/3.1.12 ThunderGit/0.1a
In-Reply-To: <20110913220421.GA24549@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181348>

On 09/14/2011 12:04 AM, Jeff King wrote:
> On Tue, Sep 13, 2011 at 05:58:25PM -0400, Jeff King wrote:
> 
>> @@ -609,26 +610,23 @@ int finish_async(struct async *async)
>>   int run_hook(const char *index_file, const char *name, ...)
>>   {
>>   	struct child_process hook;
>> -	const char **argv = NULL, *env[2];
>> +	struct argv_array argv = ARGV_ARRAY_INIT;
> 
> I find this diff function header pretty confusing. Of course we're not
> in finish_async, as you can see by the fact that the context contains
> the start of run_hook.
> 
> I don't think this is something that can be solved with xfuncname
> config; we would have to teach xdiff to look at context lines when
> picking a header line.
> 
> Am I the only one who finds this confusing? Can anyone think of a reason
> to keep showing finish_async in this example?
> 

I've never thought about the problem as I tend to read changes and
context before header.

Current behaviour makes sense if the closing brace of the previous
function is inside the context, so if we're going to change this,
we'd either have to teach xfuncname() (or whatever we'll be using)
about indentation to make it handle bannerstyle[1] indentation, or
take any closing brace before a new first-level indentation as a
sign to close the previous function. OTOH we could just ignore
bannerstyle indent, as it's sort of bizarre and not very widely
used, but we'd still have to handle the case of the previous
function being closed inside the context.

Personally, I don't think it's worth it, but I certainly see your
point.


*1. Bannerstyle indent looks like this, for those who aren't
    familiar with this very confusing style.
int prefixcmp(char *haystack, char *needle) {
	return strncmp(haystack, needle, strlen(needle));
	}

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
