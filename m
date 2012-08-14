From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Add option to limit repositories to be shown
 by ServerName
Date: Tue, 14 Aug 2012 10:11:47 -0600
Message-ID: <502A78C3.8090809@eaglescrag.net>
References: <d4f61bb06c9a125113442ae63be15ccea9464afd.1344932897.git.minovotn@redhat.com> <7v628l8noh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michal Novotny <minovotn@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 18:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Jim-0003ES-FM
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 18:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab2HNQLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 12:11:49 -0400
Received: from shards.monkeyblade.net ([149.20.54.216]:33901 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab2HNQLs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 12:11:48 -0400
Received: from voot-cruiser.eaglescrag.net (50-77-41-5-static.hfc.comcastbusiness.net [50.77.41.5])
	by shards.monkeyblade.net (Postfix) with ESMTPSA id DCF30584932;
	Tue, 14 Aug 2012 09:11:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120605 Thunderbird/13.0
In-Reply-To: <7v628l8noh.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203409>

On 08/14/2012 10:04 AM, Junio C Hamano wrote:
> Michal Novotny <minovotn@redhat.com> writes:
> 
>> this is the patch to limit repositories to be shown by the
>> ServerName in the gitweb.cgi script. This is useful for cases
>> you're hosting multiple websites on a single machine and you don't
>> want all the repos to be shown in all of them.
>> ...
>> Use case scenario: Imagine you have one server running HTTPd
>>                    for 3 domains, let's call them domain1,
>>                    domain2 and domain3, and you want all of
>>                    them to have a git server accessible via
>>                    gitweb at these URLs:
>>                    1) http://domain1/git
>>                    2) http://domain2/git
>>                    3) http://domain3/git
> 
> 
> I do not run gitweb myself, but isn't the problem you are describing
> merely a symptom caused by your <VirtualHost /> sections that are
> not configured correctly, and instead having a single instance of
> gitweb cgi enabled for all the virtual hosts?  Why does such a
> physical host want to have git repositories for different domains in
> a single place that is covered by a single instance of gitweb (hence
> a single $projectroot) in the first place?  After all, domain1's
> notion of "kernel git repository" http://domain1/git/kernel.git
> might be totally different from that of domain2's, so wouldn't it be
> far more natural to have one $projectroot (hence one instance of
> gitweb) per such domains, configured in their own <VirtualHost />
> sections?
> 
> Also, there may even be http://domain3/git that does not want to be
> served by gitweb but something else, e.g. cgit, on the same physical
> host, and in such a case, the approach taken by this patch still uses
> gitweb only to fail the request without letting cgit have its
> chance, no?

The use case scenario is doable with Apache's vhost directives, and is
likely a much better way to accomplish this then trying to teach gitweb
about vhosting.

http://httpd.apache.org/docs/2.2/vhosts/mass.html

should give some hints on how this can be done, but the long and the
short is, single install of gitweb with the config file using, say %0,
to dynamically figure out which domain to work from.

- John
