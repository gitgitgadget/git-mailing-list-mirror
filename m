From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Thu, 24 Jul 2014 22:22:33 +0100
Message-ID: <53D17919.4020702@ramsay1.demon.co.uk>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>	<vpqlhrjqmyw.fsf@anie.imag.fr>	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>	<xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>	<53D15EB4.1050303@gmail.com> <xmqqlhri8rdb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 23:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAQTK-0001DM-2Y
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 23:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759784AbaGXVWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 17:22:38 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:36976 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759775AbaGXVWh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 17:22:37 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D5D2C384084;
	Thu, 24 Jul 2014 20:45:14 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A1C57384081;
	Thu, 24 Jul 2014 20:45:14 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 24 Jul 2014 20:45:14 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqlhri8rdb.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254186>

On 24/07/14 20:54, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> If we take the easy way out, fixing UI mistakes would be easier,
>> just replace git_config_cache() with git_config_raw() for such cases.
> 
> I do not think that would fly well.
> 
> The kind of "let's migrate funcname users to xfuncname while still
> supporting the old uses" change will be done in the callback
> functions like userdiff_config().  But it is very typical that
> multiple config callback functions are cascaded (e.g. many
> eventually end up calling git_default_core_config()); in order to a
> workaround you suggest to help a callback in deep in a cascade chain
> would require you to see which ones among all the callback functions
> will eventually call the callback you are updating for migration and
> update all git_config() calls to git_config_raw().
> 
> If you fix it properly (assuming it is feasible; I haven't heard if
> you even tried to see how much work it would involve), you do not
> need to introduce "git_config_cached()" (or "_raw()" for that
> matter), which is a huge plus.  git_config() would instead do the
> right thing automatically, giving the same semantics except that it
> does not read the same file twice when it is known that the file has
> not changed.
> 

I haven't been following this conversation too closely, so if I have
grasped the wrong end of this stick, please accept my apologies! ;-)

Usually if you need to iterate the values in a hash-table in the order
of key insertion, you would simply link the hash-table entries into a
linked list. This assumes that the keys are distinct, or if not, that
you are using a 'multi-map' type of hash-table. Here, if memory serves
me, you are doing the 'multi' bit yourself within the single hash-table
entry for a given key; so its not quite so easy.

However, I think it you could create a list of <pointer to hash-table
entry, string-list index> pairs in the config_set and use that to do
the iteration. A bit ugly, but it should work.

HTH

ATB,
Ramsay Jones
