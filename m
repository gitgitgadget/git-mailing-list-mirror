From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is git over http (git-http-push) ready for production ?
Date: Fri, 19 Feb 2010 11:05:12 -0800
Message-ID: <ec874dac1002191105m6022ecdfv932a7e52eb66eb32@mail.gmail.com>
References: <hllp07$o78$1@ger.gmane.org> <20100219140419.GB31796@Knoppix> 
	<hlm9i0$ghd$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Fabien <fabien.ubuntu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:05:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiYAZ-0000Cg-B9
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 20:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab0BSTFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 14:05:34 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:37799 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab0BSTFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 14:05:33 -0500
Received: by ewy28 with SMTP id 28so481496ewy.28
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 11:05:32 -0800 (PST)
Received: by 10.216.172.203 with SMTP id t53mr3468685wel.56.1266606332187; 
	Fri, 19 Feb 2010 11:05:32 -0800 (PST)
In-Reply-To: <hlm9i0$ghd$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140478>

On Fri, Feb 19, 2010 at 7:08 AM, Fabien <fabien.ubuntu@gmail.com> wrote:
> Ilari Liusvaara wrote:
>> 1.6.6 introduced Smart HTTP. It is much more efficient, can run hooks and
>> has same kind of atomicity guarantees as ssh://, but it has few shorcomings:
>>
>> - Requires server support (CGI script & Git 1.6.6+)
>> - Hook messages don't work (at least with 1.6.6.X/1.7.0.X)
>> - Requires 1.6.6+ on client side
>> - Authentication still sucks (no surprise, auth with HTTP just plain sucks).
>
> Ok, thanks ! I wasn't aware of this new feature.
> I'll give it a try.
> What do you mean by "Hook messages don't work" ?

Normally over ssh:// output from a hook script is sent to the client's
stderr stream.  This is handled by the SSH connection itself, not by
Git, as SSH has two data channels from server to client (stdout,
stderr).  Under http:// we only have one data stream, so only the git
data that normally goes over stdout gets sent to  the client.  The
hook messages that are sent to stderr wind up in the HTTP server's
error log file.

I've posted patches to multiplex these messages into the git data
stream, but as far as I know, they aren't in a shipping version of Git
yet.
