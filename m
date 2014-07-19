From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] add documentation for writing config files
Date: Sat, 19 Jul 2014 19:35:08 +0100
Organization: OPDS
Message-ID: <7DFDF6A1361542EE9BA73AB52B1234AF@PhilipOakley>
References: <1405782354-13929-1-git-send-email-tanayabh@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Tanay Abhra" <tanayabh@gmail.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Tanay Abhra" <tanayabh@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:35:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8ZTa-00077O-MD
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 20:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbaGSSfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 14:35:12 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:42509 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932476AbaGSSfL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jul 2014 14:35:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYXAHC5ylMCYJvtPGdsb2JhbABZgw5jRocvgQTEEwUBAgEBDHoXBAEBAQE4NoN+BgEFCAEBLh4BASELAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiB0DFbIaiHINhyMXjR6BSWQ1gwCBGAWKK4QKgmeIBoodhXmJYTwvgQM
X-IPAS-Result: AvYXAHC5ylMCYJvtPGdsb2JhbABZgw5jRocvgQTEEwUBAgEBDHoXBAEBAQE4NoN+BgEFCAEBLh4BASELAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiB0DFbIaiHINhyMXjR6BSWQ1gwCBGAWKK4QKgmeIBoodhXmJYTwvgQM
X-IronPort-AV: E=Sophos;i="5.01,692,1400022000"; 
   d="scan'208";a="505560187"
Received: from host-2-96-155-237.as13285.net (HELO PhilipOakley) ([2.96.155.237])
  by out1.ip03ir2.opaltelecom.net with SMTP; 19 Jul 2014 19:35:09 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253905>

minor nit.
From: "Tanay Abhra" <tanayabh@gmail.com>
> Replace TODO introduced in commit 9c3c22 with documentation
> explaining Git config API functions for writing configuration
> files.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> Documentation/technical/api-config.txt | 31 
> ++++++++++++++++++++++++++++++-
> 1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/api-config.txt 
> b/Documentation/technical/api-config.txt
> index 230b3a0..df08385 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -137,4 +137,33 @@ int read_file_with_include(const char *file, 
> config_fn_t fn, void *data)
> Writing Config Files
> --------------------
>
> -TODO
> +Git gives multiple entry points in the Config API to write config 
> values to
> +files namely `git_config_set_in_file` and `git_config_set`, which 
> write to
> +a specific config file or to `.git/config` respectively. They both 
> take a
> +key/value pair as parameter.
> +In the end they both all call `git_config_set_multivar_in_file` which 
> takes

s/both //    'both all' is a bit tautological.

> +four parameters:
> +
> +- the name of the file, as a string, to which key/value pairs will be 
> written.
> +
> +- the name of key, as a string. This is in canonical "flat" form: the 
> section,
> +  subsection, and variable segments will be separated by dots, and 
> the section
> +  and variable segments will be all lowercase.
> +  E.g., `core.ignorecase`, `diff.SomeType.textconv`.
> +
> +- the value of the variable, as a string. If value is equal to NULL, 
> it will
> +  remove the matching key from the config file.
> +
> +- the value regex, as a string. It will disregard key/value pairs 
> where value
> +  does not match.
> +
> +- a multi_replace value, as an int. If value is equal to zero, 
> nothing or only
> +  one matching key/value is replaced, else all matching key/values 
> (regardless
> +  how many) are removed, before the new pair is written.
> +
> +It returns 0 on success.
> +
> +Also, there are functions `git_config_rename_section` and
> +`git_config_rename_section_in_file` with parameters `old_name` and 
> `new_name`
> +for renaming or removing sections in the config files. If NULL is 
> passed
> +through `new_name` parameter, the section will be removed from the 
> config file.
> -- 
> 1.9.0.GIT
>
> --
Philip 
