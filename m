From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: On undoing a forced push
Date: Tue, 09 Jun 2015 18:29:34 +0200
Organization: gmx
Message-ID: <012a980b0b9f1aa394e2b3701e4e6f97@www.dscho.org>
References: <20150609121221.GA14126@lanh> <5576F2DC.7040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 18:29:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MPM-0001p9-OR
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbbFIQ3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:29:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:63596 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420AbbFIQ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 12:29:38 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M3igT-1ZJtM61kw5-00rHtB; Tue, 09 Jun 2015 18:29:35
 +0200
In-Reply-To: <5576F2DC.7040603@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:/x6JDSbCVMCA+LKwNoF7Zyh8Is4eLMr3rZXjMao/8ERPduY6fIj
 UqhbvrHzHfrnNSjnynSKqKaW39GNz2vSqqWtaEIzaJPhvIH97i01+U2VwqrZnZQdA4sgGQy
 GlQz5Py69H9ba6fbkfPMBLSUre/r590+ZeC1rCZEQDZsPCrHhZoPrmPFXQcwSiVl1K2oHR+
 Hjtmi+CeuzHGcWQVwenzg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271197>

Hi,

On 2015-06-09 16:06, Sitaram Chamarty wrote:
> On 06/09/2015 05:42 PM, Duy Nguyen wrote:
>> From a thread on Hacker News. It seems that if a user does not have
>> access to the remote's reflog and accidentally forces a push to a ref,
>> how does he recover it? In order to force push again to revert it
>> back, he would need to know the remote's old SHA-1. Local reflog does
>> not help because remote refs are not updated during a push.
>>
>> This patch prints the latest SHA-1 before the forced push in full. He
>> then can do
>>
>>     git push <remote> +<old-sha1>:<ref>
>>
>> He does not even need to have the objects that <old-sha1> refers
>> to. We could simply push an empty pack and the the remote will happily
>> accept the force, assuming garbage collection has not happened. But
>> that's another and a little more complex patch.
> 
> If I am not mistaken, we actively prevent people from downloading an
> unreferenced SHA (such as would happen if you overwrote refs that
> contained sensitive information like passwords).
> 
> Wouldn't allowing the kind of push you just described, require negating
> that protection?

I believe that to be the case.

Sorry to chime in so late in the discussion, but I think that the `--force-with-lease` option is what you are looking for. It allows you to force-push *but only* if the forced push would overwrite the ref we expect, i.e. (simplified, but you get the idea) `git push --force-with-lease <remote> <ref>` will *only* succeed if the remote's <ref> agrees with the local `refs/remotes/<remote>/<ref>`.

If you use `--force-with-lease`, you simply cannot force-forget anything on the remote side that you cannot undo (because you have everything locally you need to undo it).

Ciao,
Johannes
