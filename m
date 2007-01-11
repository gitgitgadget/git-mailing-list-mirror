From: Andy Parkins <andyparkins@gmail.com>
Subject: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 09:41:17 +0000
Message-ID: <200701110941.22024.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 11 10:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wR7-0000Dv-TA
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965356AbXAKJl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbXAKJl1
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:41:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:48985 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965356AbXAKJl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:41:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so404529uga
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 01:41:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KxZrT9UkhZ1sF7K8dWk933sDYBVy5qSTwGIRq0dl2+37YpRWOhIR0Re7+VErqziupMSE0jrouk23AHCbeXb86khhSMZHR0hj3w4GOMg/imH2/u1F+b5gUP3nnlCE7iRl3ucvwTusmNn8jkUso61s33otasCt1It80BoM1lPjddo=
Received: by 10.67.22.2 with SMTP id z2mr1452217ugi.1168508485407;
        Thu, 11 Jan 2007 01:41:25 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id 5sm449961ugc.2007.01.11.01.41.24;
        Thu, 11 Jan 2007 01:41:24 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36566>

Hello,

I am sure the response to this will be "tough", however I'll mention it 
anyway.  It wasn't a problem for me, as I know git is LF endings only, but 
others might be a bit confused.

 * Track a file that has CR-LF endings.  Not a problem, git works fine with 
   these and treats the CR as an extra character at the end of the line.
 * Have two branches make conflicting changes to that file
 * Merge, conflict
 * Open the file
 * Find that (almost) every line now displays with a "^M" at the end.  vim has
   found some lines that don't have CR-LF ends so dropped back to UNIX mode.
 * Be careful that your conflict resolution doesn't introduce any new lines as 
   they will not have CR-LF endings.

The "(almost)" above refers of course to the conflict markers.  These have LF 
endings only so force the editor into UNIX mode.  Assuming a binary safe 
editor, things will be fine if the conflict resolution is simply to remove 
the markers, and edit the existing lines.  However, if the user adds any 
lines during conflict resolution, those new lines will only have LF ends.

This is a problem for compilers that are expecting CR-LF input.

Note: this is not on Windows (spit), this is simply editing a CR-LF file on 
UNIX.

The best solution is probably to use the line ending of the conflicted lines.  
I've had a look, but I can only fine builtin-rerere.c that generates the 
markers - would that be the place to make this change?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
