From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 10/11] gitweb.js: Add UI for selecting common timezone to display dates
Date: Tue, 12 Apr 2011 15:24:50 +0200
Message-ID: <201104121524.52412.jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com> <BANLkTik9D6++P1rg+VbvKj9oTFhRYNmrpQ@mail.gmail.com> <201104121444.20633.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:26:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9dbt-0004fl-CY
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 15:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab1DLN0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 09:26:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46227 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab1DLN0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 09:26:05 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so5357326bwz.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=xT+k91dggIYmWe2F5KWDlaNTMtOg/qVgzIychHsZmEU=;
        b=OhLF3zA3o7ZijlwI3gh1cPwZWvCRJbVIjxLciFvXxPNTa0f7Ali0jAczMGezTOQ+S3
         DIwHt3kRl2hCfdFrZbUvYNcgK/fI8bG1IwtxlVl4yCFpAocHfhWekw2s5KMqkJ748buo
         DUvDGRwcecMn+YmgUwUnQXcWmWKkcZVIJiQzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZMFxgjL4TRD3YATpiwoXMAZfBY7+ChtAbiOdbolFdUsIw09q6bXhIiIKrcSd8FAb8Z
         A6LzQ0UavWAB904OwSw9oxXcrgeByOqjXWMKV0mNdQ9dyjqlo6xs/05rTaMi1caUr3+a
         YBYdE6luf2+Rx5CnwQn2U31T4T8ACaYGH0G5M=
Received: by 10.204.126.144 with SMTP id c16mr6076099bks.6.1302614764638;
        Tue, 12 Apr 2011 06:26:04 -0700 (PDT)
Received: from [192.168.1.13] (abvr44.neoplus.adsl.tpnet.pl [83.8.215.44])
        by mx.google.com with ESMTPS id v21sm3859967bkt.23.2011.04.12.06.26.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2011 06:26:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201104121444.20633.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171390>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This will modify HTML, add CSS rules and add DOM event handlers so
that clicking on any date (the common part, not the localtime part)
will display a drop down menu to choose the timezone to change to.

Currently menu displays only the following timezones:

  utc
  local
  -1200
  -1100
  ...
  +1100
  +1200
  +1300
  +1400

In timezone selection menu each timezone is +1hr to the previous.  The
code is capable of handling fractional timezones, but those have not
been added to the menu.

All changes are saved to a cookie, so page changes and closing /
reopening browser retains the last known timezone setting used.

[jn: Changed from innerHTML to DOM, moved to event delegation for
onclick to trigger menu, added close button and cookie refreshing]

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Bugs-reported-by: Kevin Cernekee <cernekee@gmail.com>

Differences from v1:
* Fixed bug in gitweb.css (only /* ... */ are comments).
* fixDatetimeTZ didn't update timezone correctly if cookie was
  deleted and 'utc' timezone selected from menu
* Fix addCssRule for IE (typofix)
* Change code so that the fact that Opera 10.63 resets
  target.selectedIndex to 1 after calling removeChangeTZForm()
  doesn't affect timezone selection result.

* Pass all cookie parameters from gitweb.perl
* Increase cookie expiration time from 7 to 14 days
* Extract/refactor generateTZOptions function 
  (this makes createChangeTZForm code shorter)
* select.onchange, select.onblur, close-button.onclick handlers
  are now generated (this makes createChangeTZForm code shorter)
* removeChangeTZForm is more robust wrt future changes
* moved from top+right to top+left positioning, because it works
  correctly in wider range of [buggy] web browsers

 gitweb/gitweb.perl                  |    3 +-
 gitweb/static/gitweb.css            |   33 ++++
 gitweb/static/js/adjust-timezone.js |  294 +++++++++++++++++++++++++++++++++--
 gitweb/static/js/lib/common-lib.js  |   27 +++-
 4 files changed, 342 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6651946..b1e80ef 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3738,7 +3738,8 @@ sub git_footer_html {
 		      (gitweb_check_feature('javascript-actions') ?
 		      qq!	fixLinks();\n! : '').
 		      # last parameter to onloadTZSetup must be CSS class used by format_timestamp_html
-		      qq!	onloadTZSetup('local', 'gitweb_tz', 'datetime');\n!.
+		      qq!	var tz_cookie = { name: 'gitweb_tz', expires: 14, path: '/' };\n!. # in days
+		      qq!	onloadTZSetup('local', tz_cookie, 'datetime');\n!.
 		      qq!};\n!.
 		      qq!</script>\n!;
 	}
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 79d7eeb..8dd0935 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -579,6 +579,39 @@ div.remote {
 	display: inline-block;
 }
 
+/* JavaScript-based timezone manipulation */
+
+.popup { /* timezone selection UI */
+	position: absolute;
+	/* "top: 0; right: 0;" would be better, if not for bugs in browsers */
+	top: 0; left: 0;
+	border: 1px solid;
+	padding: 2px;
+	background-color: #f0f0f0;
+	font-style: normal;
+	color: #000000;
+	cursor: auto;
+}
+
+.close-button { /* close timezone selection UI without selecting */
+	/* float doesn't work within absolutely positioned container,
+	 * if width of container is not set explicitly */
+	/* float: right; */
+	position: absolute;
+	top: 0px; right: 0px;
+	border:  1px solid green;
+	margin:  1px 1px 1px 1px;
+	padding-bottom: 2px;
+	width:     12px;
+	height:    10px;
+	font-size:  9px;
+	font-weight: bold;
+	text-align: center;
+	background-color: #fff0f0;
+	cursor: pointer;
+}
+
+
 /* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
 
 /* Highlighting theme definition: */
diff --git a/gitweb/static/js/adjust-timezone.js b/gitweb/static/js/adjust-timezone.js
index c9b69c3..f1e97a6 100644
--- a/gitweb/static/js/adjust-timezone.js
+++ b/gitweb/static/js/adjust-timezone.js
@@ -7,34 +7,51 @@
  */
 
 /**
- * Get common timezone and adjust dates to use this common timezone.
+ * Get common timezone, add UI for changing timezones, and adjust
+ * dates to use requested common timezone.
  *
  * This function is called during onload event (added to window.onload).
  *
  * @param {String} tzDefault: default timezone, if there is no cookie
- * @param {String} tzCookieName: name of cookie to store timezone
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @param {String} tzCookieInfo.name: name of cookie to store timezone
  * @param {String} tzClassName: denotes elements with date to be adjusted
  */
-function onloadTZSetup(tzDefault, tzCookieName, tzClassName) {
-	var tzCookie = getCookie(tzCookieName);
-	var tz = tzCookie ? tzCookie : tzDefault;
+function onloadTZSetup(tzDefault, tzCookieInfo, tzClassName) {
+	var tzCookieTZ = getCookie(tzCookieInfo.name, tzCookieInfo);
+	var tz = tzDefault;
+
+	if (tzCookieTZ) {
+		// set timezone to value saved in a cookie
+		tz = tzCookieTZ;
+		// refresh cookie, so its expiration counts from last use of gitweb
+		setCookie(tzCookieInfo.name, tzCookieTZ, tzCookieInfo);
+	}
+
+	// add UI for changing timezone
+	addChangeTZ(tz, tzCookieInfo, tzClassName);
 
 	// server-side of gitweb produces datetime in UTC,
 	// so if tz is 'utc' there is no need for changes
-	if (tz !== 'utc') {
-		fixDatetimeTZ(tz, tzClassName);
-	}
+	var nochange = tz === 'utc';
+
+	// adjust dates to use specified common timezone
+	fixDatetimeTZ(tz, tzClassName, nochange);
 }
 
 
+/* ...................................................................... */
+/* Changing dates to use requested timezone */
+
 /**
  * Replace RFC-2822 dates contained in SPAN elements with tzClassName
  * CSS class with equivalent dates in given timezone.
  *
  * @param {String} tz: numeric timezone in '(-|+)HHMM' format, or 'utc', or 'local'
  * @param {String} tzClassName: specifies elements to be changed
+ * @param {Boolean} nochange: markup for timezone change, but don't change it
  */
-function fixDatetimeTZ(tz, tzClassName) {
+function fixDatetimeTZ(tz, tzClassName, nochange) {
 	// sanity check, method should be ensured by common-lib.js
 	if (!document.getElementsByClassName) {
 		return;
@@ -48,12 +65,263 @@ function fixDatetimeTZ(tz, tzClassName) {
 	for (var i = 0, len = classesFound.length; i < len; i++) {
 		var curElement = classesFound[i];
 
-		var epoch = parseRFC2822Date(curElement.innerHTML);
-		var adjusted = formatDateRFC2882(epoch, tz);
+		curElement.title = 'Click to change timezone';
+		if (!nochange) {
+			var epoch = parseRFC2822Date(curElement.innerHTML);
+			var adjusted = formatDateRFC2882(epoch, tz);
+
+			// curElement.innerHTML = adjusted; // does not work for Mozilla 1.17.2
+			curElement.firstChild.data = adjusted;
+		}
+	}
+}
+
+
+/* ...................................................................... */
+/* Adding triggers, generating timezone menu, displaying and hiding */
+
+/**
+ * Adds triggers for UI to change common timezone used for dates in
+ * gitweb output: it marks up and/or creates item to click to invoke
+ * timezone change UI, creates timezone UI fragment to be attached,
+ * and installs appropriate onclick trigger (via event delegation).
+ *
+ * @param {String} tzSelected: pre-selected timezone,
+ *                             'utc' or 'local' or '(-|+)HHMM'
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @param {String} tzClassName: specifies elements to install trigger
+ */
+function addChangeTZ(tzSelected, tzCookieInfo, tzClassName) {
+	// make link to timezone UI discoverable
+	addCssRule('.'+tzClassName + ':hover',
+	           'text-decoration: underline; cursor: help;');
+
+	// create form for selecting timezone (to be saved in a cookie)
+	var tzSelectFragment = document.createDocumentFragment();
+	tzSelectFragment = createChangeTZForm(tzSelectFragment,
+	                                      tzSelected, tzCookieInfo, tzClassName);
+
+	// event delegation handler for timezone selection UI (clicking on entry)
+	// see http://www.nczonline.net/blog/2009/06/30/event-delegation-in-javascript/
+	// assumes that there is no existing document.onclick handler
+	document.onclick = function onclickHandler(event) {
+		//IE doesn't pass in the event object
+		event = event || window.event;
+
+		//IE uses srcElement as the target
+		var target = event.target || event.srcElement;
+
+		switch (target.className) {
+		case tzClassName:
+			displayChangeTZForm(target, tzSelectFragment);
+			break;
+		} // end switch
+	};
+}
+
+/**
+ * Create DocumentFragment with UI for changing common timezone in
+ * which dates are shown in.
+ *
+ * @param {DocumentFragment} documentFragment: where attach UI
+ * @param {String} tzSelected: default (pre-selected) timezone
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @returns {DocumentFragment}
+ */
+function createChangeTZForm(documentFragment, tzSelected, tzCookieInfo, tzClassName) {
+	var div = document.createElement("div");
+	div.className = 'popup';
+
+	/* '<div class="close-button" title="(click on this box to close)">X</div>' */
+	var closeButton = document.createElement('div');
+	closeButton.className = 'close-button';
+	closeButton.title = '(click on this box to close)';
+	closeButton.appendChild(document.createTextNode('X'));
+	closeButton.onclick = closeTZFormHandler(documentFragment, tzClassName);
+	div.appendChild(closeButton);
+
+	/* 'Select timezone: <br clear="all">' */
+	div.appendChild(document.createTextNode('Select timezone: '));
+	var br = document.createElement('br');
+	br.clear = 'all';
+	div.appendChild(br);
+
+	/* '<select name="tzoffset">
+	 *    ...
+	 *    <option value="-0700">UTC-07:00</option>
+	 *    <option value="-0600">UTC-06:00</option>
+	 *    ...
+	 *  </select>' */
+	var select = document.createElement("select");
+	select.name = "tzoffset";
+	//select.style.clear = 'all';
+	select.appendChild(generateTZOptions(tzSelected));
+	select.onchange = selectTZHandler(documentFragment, tzCookieInfo, tzClassName);
+	// NOTE: onblur removal might be not necessary with close button
+	select.onblur = closeTZFormHandler(documentFragment, tzClassName);
+	div.appendChild(select);
+
+	documentFragment.appendChild(div);
+
+	return documentFragment;
+}
+
+
+/**
+ * Hide (remove from DOM) timezone change UI, ensuring that it is not
+ * garbage collected and that it can be re-enabled later.
+ *
+ * @param {DocumentFragment} documentFragment: contains detached UI
+ * @param {HTMLSelectElement} target: select element inside of UI
+ * @param {String} tzClassName: specifies element where UI was installed
+ * @returns {DocumentFragment} documentFragment
+ */
+function removeChangeTZForm(documentFragment, target, tzClassName) {
+	// find containing element, where we appended timezone selection UI
+	// `target' is somewhere inside timezone menu
+	var container = target.parentNode, popup = target;
+	while (container &&
+	       container.className !== tzClassName) {
+		popup = container;
+		container = container.parentNode;
+	}
+	// safety check if we found correct container,
+	// and if it isn't deleted already
+	if (!container || !popup ||
+	    container.className !== tzClassName ||
+	    popup.className     !== 'popup') {
+		return documentFragment;
+	}
 
-		// curElement.innerHTML = adjusted; // does not work for Mozilla 1.17.2
-		curElement.firstChild.data = adjusted;
+	// timezone selection UI was appended as last child
+	// see also displayChangeTZForm function
+	var removed = container.removeChild(popup);
+	if (documentFragment.firstChild !== removed) { // the only child
+		// re-append it so it would be available for next time
+		documentFragment.appendChild(removed);
 	}
+	// all of inline style was added by this script
+	container.removeAttribute('style');
+
+	return documentFragment;
+}
+
+
+/**
+ * Display UI for changing common timezone for dates in gitweb output.
+ * To be used from 'onclick' event handler.
+ *
+ * @param {HTMLElement} target: where to install/display UI
+ * @param {DocumentFragment} tzSelectFragment: timezone selection UI
+ */
+function displayChangeTZForm(target, tzSelectFragment) {
+	// for absolute positioning to be related to target element
+	target.style.position = 'relative';
+	target.style.display = 'inline-block';
+
+	// show/display UI for changing timezone
+	target.appendChild(tzSelectFragment);
+}
+
+
+/* ...................................................................... */
+/* List of timezones for timezone selection menu */
+
+/**
+ * Generate list of timezones for creating timezone select UI
+ *
+ * @returns {Object[]} list of e.g. { value: '+0100', descr: 'GMT+01:00' }
+ */
+function generateTZList() {
+	var timezones = [
+		{ value: "utc",   descr: "UTC/GMT"},
+		{ value: "local", descr: "Local (per browser)"}
+	];
+
+	// generate all full hour timezones (no fractional timezones)
+	for (var x = -12, idx = timezones.length; x <= +14; x++, idx++) {
+		var hours = (x >= 0 ? '+' : '-') + padLeft(x >=0 ? x : -x, 2);
+		timezones[idx] = { value: hours + '00', descr: 'UTC' + hours + ':00'};
+		if (x === 0) {
+			timezones[idx].descr = 'UTC\u00B100:00'; // 'UTC&plusmn;00:00'
+		}
+	}
+
+	return timezones;
+}
+
+/**
+ * Generate <options> elements for timezone select UI
+ *
+ * @param {String} tzSelected: default timezone
+ * @returns {DocumentFragment} list of options elements to appendChild
+ */
+function generateTZOptions(tzSelected) {
+	var elems = document.createDocumentFragment();
+	var timezones = generateTZList();
+
+	for (var i = 0, len = timezones.length; i < len; i++) {
+		var tzone = timezones[i];
+		var option = document.createElement("option");
+		if (tzone.value === tzSelected) {
+			option.defaultSelected = true;
+		}
+		option.value = tzone.value;
+		option.appendChild(document.createTextNode(tzone.descr));
+
+		elems.appendChild(option);
+	}
+
+	return elems;
+}
+
+
+/* ...................................................................... */
+/* Event handlers and/or their generators */
+
+/**
+ * Create event handler that select timezone and closes timezone select UI.
+ * To be used as $('select[name="tzselect"]').onchange handler.
+ *
+ * @param {DocumentFragment} tzSelectFragment: timezone selection UI
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @param {String} tzCookieInfo.name: name of cookie to save result of selection
+ * @param {String} tzClassName: specifies element where UI was installed
+ * @returns {Function} event handler
+ */
+function selectTZHandler(tzSelectFragment, tzCookieInfo, tzClassName) {
+	//return function selectTZ(event) {
+	return function (event) {
+		event = event || window.event;
+		var target = event.target || event.srcElement;
+
+		var selected = target.options.item(target.selectedIndex);
+		removeChangeTZForm(tzSelectFragment, target, tzClassName);
+
+		if (selected) {
+			selected.defaultSelected = true;
+			setCookie(tzCookieInfo.name, selected.value, tzCookieInfo);
+			fixDatetimeTZ(selected.value, tzClassName);
+		}
+	};
+}
+
+/**
+ * Create event handler that closes timezone select UI.
+ * To be used e.g. as $('.closebutton').onclick handler.
+ *
+ * @param {DocumentFragment} tzSelectFragment: timezone selection UI
+ * @param {String} tzClassName: specifies element where UI was installed
+ * @returns {Function} event handler
+ */
+function closeTZFormHandler(tzSelectFragment, tzClassName) {
+	//return function closeTZForm(event) {
+	return function (event) {
+		event = event || window.event;
+		var target = event.target || event.srcElement;
+
+		removeChangeTZForm(tzSelectFragment, target, tzClassName);
+	};
 }
 
 /* end of adjust-timezone.js */
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index b371391..018bbb7 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -64,7 +64,7 @@ function padLeft(input, width, ch) {
 
 
 /* ............................................................ */
-/* Ajax */
+/* Handling browser incompatibilities */
 
 /**
  * Create XMLHttpRequest object in cross-browser way
@@ -88,6 +88,31 @@ function createRequestObject() {
 }
 
 
+/**
+ * Insert rule giving specified STYLE to given SELECTOR at the end of
+ * first CSS stylesheet.
+ *
+ * @param {String} selector: CSS selector, e.g. '.class'
+ * @param {String} style: rule contents, e.g. 'background-color: red;'
+ */
+function addCssRule(selector, style) {
+	var stylesheet = document.styleSheets[0];
+
+	var theRules = [];
+	if (stylesheet.cssRules) {     // W3C way
+		theRules = stylesheet.cssRules;
+	} else if (stylesheet.rules) { // IE way
+		theRules = stylesheet.rules;
+	}
+
+	if (stylesheet.insertRule) {    // W3C way
+		stylesheet.insertRule(selector + ' { ' + style + ' }', theRules.length);
+	} else if (stylesheet.addRule) { // IE way
+		stylesheet.addRule(selector, style);
+	}
+}
+
+
 /* ............................................................ */
 /* Support for legacy browsers */
 
-- 
1.7.3
