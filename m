From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 3/5] Help.c add --guide option
Date: Mon, 4 Mar 2013 00:04:36 -0000
Organization: OPDS
Message-ID: <667B2BF898CC4491BE02C1142472A833@PhilipOakley>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org> <1362342072-1412-4-git-send-email-philipoakley@iee.org> <7vk3poyryc.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 01:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIt6-0005T0-Nr
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 01:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab3CDADu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 19:03:50 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:42873 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753217Ab3CDADt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 19:03:49 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAMTAM1FZ8rke/2dsb2JhbABFjAy2Pn0Xc4IaBQEBBAEIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBh3wKxw+OPlQLgmZhA4g2hWSZGIMI
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="420387050"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with SMTP; 04 Mar 2013 00:03:48 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217380>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, March 03, 2013 11:38 PM
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Logic, but no actions, included.
>
> I am not sure what you mean.  Is that to break "bisect"?
>
> Ahh, you meant "command line is parsed but we do not actually show
> guides yet, which is done by later patches in this series".  OK.
True. I can add to the commit message.

>
>> The --all commands option, if given, will display first.
>> The --guide option's list will then be displayed.
>>
>> The common commands list is only displayed if neither option,
>> nor a command or guide name, is given.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  builtin/help.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index d10cbed..6089d72 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -36,10 +36,12 @@ enum help_format {
>>  static const char *html_path;
>>
>>  static int show_all = 0;
>> +static int show_guides = 0;
>>  static unsigned int colopts;
>>  static enum help_format help_format = HELP_FORMAT_NONE;
>>  static struct option builtin_help_options[] = {
>>  OPT_COUNTUP('a', "all", &show_all, N_("print all available 
>> commands")),
>> + OPT_COUNTUP('g', "guides", &show_guides, N_("print list of useful 
>> guides")),
>>  OPT_SET_INT('m', "man", &help_format, N_("show man page"), 
>> HELP_FORMAT_MAN),
>>  OPT_SET_INT('w', "web", &help_format, N_("show manual in web 
>> browser"),
>>  HELP_FORMAT_WEB),
>> @@ -49,7 +51,7 @@ static struct option builtin_help_options[] = {
>>  };
>>
>>  static const char * const builtin_help_usage[] = {
>> - N_("git help [--all] [--man|--web|--info] [command]"),
>> + N_("git help [--all] [--guides] [--man|--web|--info] [command]"),
>>  NULL
>>  };
>>
>> @@ -429,9 +431,11 @@ int cmd_help(int argc, const char **argv, const 
>> char *prefix)
>>  printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>>  list_commands(colopts, &main_cmds, &other_cmds);
>>  printf("%s\n", _(git_more_info_string));
>> + if (!show_guides) return 0;
>> + }
>> + if (show_guides) {
>>  return 0;
>>  }
>> -
>
> Ugly.

I was trying to minimise the apparent changes, but like you say...

>
> if (show_all) {
>        ... do not touch anything here ...
> ... but remove "return 0;" ...
> }
>
> if (show_guides) {
>        ... show guides but do not "return 0" ...
> }
>
> if (show_all || show_guides) {
> ... we were asked to do either/or --all/--guides ...
>                ... and have done what we were asked to do ...
> return 0;
> }

Neater.

>
> This is a tangent, but before all of the above, cmd_help() should
> verify that it got no arguments (when show_all/show_guides is in
> effect) or it got one argument (otherwise), I think.
>
>>  if (!argv[0]) {
>>  printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>>  list_common_cmds_help();

Seems reasonable. Should that be a separate preparatory patch (likely), 
or joined in with the rest?

Philip 
