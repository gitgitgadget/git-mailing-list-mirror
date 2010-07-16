From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 05/11] gitweb: Create Gitweb::Request module
Date: Fri, 16 Jul 2010 02:11:41 +0200
Message-ID: <201007160211.42631.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-6-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 02:12:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZYX4-0006rx-LL
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 02:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935077Ab0GPALu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 20:11:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33201 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935075Ab0GPALt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 20:11:49 -0400
Received: by bwz1 with SMTP id 1so919958bwz.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 17:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=K0FzM6l/y1KqgpB5dDAKJc+tG2t53ixp5sL4pqrjNK0=;
        b=q5biEpAPm96sbo6e9NtK+5o8J9QIo1XYP5BSayXubgHrNa7hnSZWuvgWkqUZUoawAW
         SxIBp5ujml6Y4897L3ln8IdE5Y1wPqzLCA9V0pTYKbWRjSWlf4Go3JCoKxIMdqVv9gs4
         KRJA2PsvSA2fexd87iyqi/+lDeJHWEH/3nANk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RvI46Kyyjg6NlmLopxeb0gUxa/wIRtc4YS8TgZzDd6bRibT41DOxRyE1fpEb+1BLkC
         odVGeG5gG5x2MzCw03RifL9C8LLY+900SGKDtO8vQYG4XhSNq30zgIDaDnNpo8yCYG+V
         H4zYNeFQg4dRRf8llp9leTNbxKW0ilS9oe4qQ=
Received: by 10.204.27.20 with SMTP id g20mr313223bkc.114.1279239108314;
        Thu, 15 Jul 2010 17:11:48 -0700 (PDT)
Received: from [192.168.1.13] (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id o20sm8200045bkw.15.2010.07.15.17.11.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 17:11:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-6-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151129>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create a Gitweb::Request module in 'gitweb/lib/Gitweb/Request.pm'
> to store and handle all the cgi params and related variables
> regarding the gitweb.perl script.
> 
> This module is intended as standalone module, which does not require
> (include) other gitweb' modules to avoid circular dependencies.
> 
> Subroutines moved:
> 	evaluate_uri
> 	evaluate_query_params

Here you would really need to explain why Gitweb::Request does not
include evaluate_path_info, the companion to evaluate_query_params.
It is strange to me that query_params is in it, but path_info is not.

Would it be possible, perhaps, to modify evaluate_path_info so it can
be moved to Gitweb::Request without adding additional dependencies to
it?
 
> Update gitweb/Makefile to install Gitweb::Request module alongside gitweb
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

[...]
> --- /dev/null
> +++ b/gitweb/lib/Gitweb/Request.pm
[...]
> +our @EXPORT = qw($cgi $my_url $my_uri $base_url $path_info $home_link $action $project $file_name
> +                 $file_parent $hash $hash_parent $hash_base $hash_parent_base @extra_options $page
> +                 $searchtype $search_use_regexp $searchtext $search_regexp %input_params %allowed_options
> +                 @cgi_param_mapping %cgi_param_mapping $t0 evaluate_query_params evaluate_uri);

You are working off older base, which did not include reset_timer
subroutine, added in 869d588 (gitweb: Move evaluate_gitweb_config
out of run_request, 2010-07-05).

-- 
Jakub Narebski
Poland
